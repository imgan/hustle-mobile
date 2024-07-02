import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/arg_recovery_detail.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';

import '../../../../model/class_detail.dart';
import '../../../../model/comment.dart';
import '../../../../model/review.dart';
import '../../../../profile/bookinghistory/completedclasspage/completedclasscontroller/booking_completed_controller.dart';
import '../../../../profile/profile_controller.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/my_pref.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/dialog/alert_dialog.dart';
import '../../../../utils/widgets/error/error_book.dart';
import '../../../home/home_controller.dart';

class RecoveryDetailController extends GetxController {
  RxBool isReadMore = false.obs;
  RxBool isExpandCancellation = false.obs;
  RxBool isExpandPrepare = false.obs;
  RxBool isLoadingReview = true.obs;
  RxBool isCancel = false.obs;
  Rx<Result> recoveryState = Rx(LoadingState());
  Rxn<Review> review = Rxn();
  RxList<Comment> comments = RxList();
  RxBool isReturnCredit = false.obs;
  var arguments = Get.arguments;
  int? id;

  final RestApiController restApiController = Get.find<RestApiController>();
  var myCredit = Get.find<MyPref>().myCredit;

  @override
  void onInit() {
    id = arguments[ArgRecoveryDetail.sessionId];
    getRecoveryDetail();
    getReview();
    super.onInit();
  }

  void getRecoveryDetail() async {
    recoveryState.value = LoadingState();
    update();
    try {
      var response = await restApiController.get(
          endpoint: '${Endpoint.scheduleDetail}/$id');
      if (response?.statusCode == 200) {
        final recovery = ClassDetail.fromJson(response?.data['data']);
        recoveryState.value = SuccessState<ClassDetail>(recovery);
      } else {
        String error = response?.data['message'];
        recoveryState.value = ErrorState(error);
      }

      isCancelButton();
      checkStatusCancel();
      update();
    } on DioException catch (e) {
      recoveryState.value = ErrorState(e.message);
      update();
      log('error recovery ${e.message}');
    }
  }

  void getReview() async {
    isLoadingReview.value = true;
    update();
    try {
      final sportClassId = arguments[ArgRecoveryDetail.sportClassId];
      final queryParameter = {
        'sportsClassID': sportClassId,
        'page': 1,
        'limit': 1
      };
      var response = await restApiController.get(
          endpoint: Endpoint.reviewRecovery, queryParameters: queryParameter);
      review.value = Review.fromJson(response?.data);
      comments.value = List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x)));
      isLoadingReview.value = false;
      update();
    } on DioException catch (e) {
      isLoadingReview.value = false;
      update();
      log('error review ${e.message}');
    }
  }

  void reviewRecovery({String? rate, String? comment}) async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final id = arguments[ArgRecoveryDetail.pathId];
      final parameter = {"star_rating": rate, "comments": comment};
      if (double.parse(rate ?? '0.0') <= 0.0) {
        Get.back();
        Get.dialog(const AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: 'Please add your rating',
        ));
        return;
      }
      if ((comment?.length ?? 0) > 500) {
        Get.back();
        Get.dialog(const AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: 'Review is too long',
        ));
        return;
      }
      var response = await restApiController.post(
        endpoint: '${Endpoint.reviewClass}/$id',
        data: parameter,
      );
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog().success('Feedback Sent', () {
          Get.until((route) => Get.currentRoute == '/BookingHistoryPage');
        }));
        Get.find<BookingCompletedController>().getBookingHistoryCompleted();
        update();
      } else {
        Get.back();
        Get.dialog(AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error review ${e.message}');
    }
  }

  void cancelBook() async {
    final id = arguments[ArgRecoveryDetail.memberSessionId];
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {"memberSessionID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog()
            .success('${arguments[ArgRecoveryDetail.title]} Cancelled', () {
          Get.until((route) => Get.currentRoute == '/MainPage');
        }));
        updateProfiles();
        isCancel.value = false;
        update();
      } else {
        Get.back();
        errorBook('Cancel Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      Get.dialog(AlertPopUpDialog(
        title: 'Cancel Failed',
        subTitle: e.message ?? '',
      ));
      update();
      log('error cancel class ${e.message}');
    }
  }

  void checkStatusCancel() async {
    if (isCancel.isTrue) {
      final id = arguments[ArgRecoveryDetail.memberSessionId];
      try {
        final parameter = {"memberSessionID": id};
        var response = await restApiController.get(
            endpoint: Endpoint.checkStatusCancel, queryParameters: parameter);
        isReturnCredit.value = (response?.data['status']
                    .toString()
                    .toLowerCase()
                    .contains('not') ??
                false)
            ? true
            : false;

        update();
      } on DioException catch (e) {
        update();
        log('error status cancel ${e.message}');
      }
    }
  }

  void updateReadMore() {
    isReadMore.value = !isReadMore.value;
    update();
  }

  void updateExpandCancellation() {
    isExpandCancellation.value = !isExpandCancellation.value;
    update();
  }

  void updateExpandPrepare() {
    isExpandPrepare.value = !isExpandPrepare.value;
    update();
  }

  void isCancelButton() {
    isCancel.value = arguments[ArgRecoveryDetail.isCancel] == true ||
        arguments[ArgRecoveryDetail.isCancel] != null;
  }

  bool isCancelled() {
    return arguments[ArgRecoveryDetail.isCancelled] == true;
  }

  bool isShowDetail() {
    bool isFromUpcomingPage = Get.previousRoute == '/UpcomingClassPage';
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return isFromUpcomingPage || isFromBookingHistory && !isCancelled();
  }

  bool isShowCredit() {
    bool isFromUpcomingPage = Get.previousRoute == '/UpcomingClassPage';
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    bool isFromMainPage = Get.previousRoute == '/MainPage';
    return isFromUpcomingPage ||
        isFromMainPage ||
        isFromBookingHistory && !isCancelled();
  }

  bool isShowButtonRate() {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return isFromBookingHistory &&
        arguments.length > 2 &&
        arguments[ArgRecoveryDetail.isUserComment] == false;
  }

  bool isShowButtonAvailability() {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return !isCancelled() && !isFromBookingHistory;
  }

  void updateProfiles() {
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().getBookingHistory();
    Get.find<ProfileController>().getUpcomingClass();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
  }
}
