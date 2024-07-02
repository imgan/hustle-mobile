import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';

import '../../../../model/comment.dart';
import '../../../../model/review.dart';
import '../../../../model/trainer.dart';
import '../../../../profile/bookinghistory/completedclasspage/completedclasscontroller/booking_completed_controller.dart';
import '../../../../profile/profile_controller.dart';
import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/dialog/alert_dialog.dart';
import '../../../../utils/widgets/error/error_book.dart';
import '../../../home/home_controller.dart';

class TrainerDetailController extends GetxController {
  RxBool isReadMore = false.obs;
  Rx<Result> trainerState = Rx(LoadingState());
  RxBool isCancel = false.obs;
  Rxn<Review> review = Rxn();
  RxList<Comment> comments = RxList();
  RxBool isReturnCredit = false.obs;
  final arguments = Get.arguments;
  int? id = 0;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    id = arguments[ArgTrainerDetail.teacherId];
    getTrainer();
    getReview();
    super.onInit();
  }

  void getTrainer() async {
    trainerState.value = LoadingState();
    update();
    try {
      var response =
          await restApiController.get(endpoint: '${Endpoint.teacher}/$id');
      final trainer = Trainer.fromJson(response.data['data']);
      trainerState.value = SuccessState<Trainer>(trainer);
      isCancelButton();
      checkStatusCancel();
      update();
    } on DioException catch (e) {
      trainerState.value = ErrorState(e.message);
      update();
      log('error trainer ${e.message}');
    }
  }

  void getReview() async {
    try {
      final teacherId = arguments[ArgTrainerDetail.teacherId];
      final queryParameter = {'teacherID': teacherId, 'page': 1, 'limit': 1};
      var response = await restApiController.get(
          endpoint: Endpoint.reviewTrainer, queryParameters: queryParameter);
      review.value = Review.fromJson(response?.data);
      comments.value = List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x)));
      update();
    } on DioException catch (e) {
      log('error review ${e.message}');
    }
  }

  void reviewTrainer({String? rate, String? comment}) async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final id = arguments[ArgTrainerDetail.pathId];
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
        Get.dialog( AlertPopUpDialog(
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
    final id = arguments[ArgTrainerDetail.memberSessionId];
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {"memberSessionID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog().success('Booking Cancelled', () {
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
      Get.dialog( AlertPopUpDialog(
        title: 'Cancel Failed',
        subTitle: e.message ?? '',
      ));
      update();
      log('error cancel class ${e.message}');
    }
  }

  void checkStatusCancel() async {
    if (isCancel.isTrue) {
      final id = arguments[ArgTrainerDetail.memberSessionId];
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

  void isCancelButton() {
    isCancel.value = arguments[ArgTrainerDetail.isCancel] == true ||
        arguments[ArgTrainerDetail.isCancel] != null;
  }

  bool isCancelled() {
    return arguments[ArgTrainerDetail.isCancelled] == true;
  }

  bool isRateClass() {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return isFromBookingHistory &&
        arguments.length > 1 &&
        arguments[ArgTrainerDetail.isUserComment] == false;
  }

  void updateProfiles() {
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().getBookingHistory();
    Get.find<ProfileController>().getUpcomingClass();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
  }
}
