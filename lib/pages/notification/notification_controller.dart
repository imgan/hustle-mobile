import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/notification.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_page.dart';
import 'package:hustle_house_flutter/pages/book/class/status_book.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/profile/bookinghistory/booking_history_page.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/purchase_history_page.dart';
import 'package:hustle_house_flutter/profile/upcomingclass/upcoming_class_page.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';

import '../../profile/my_vouchers/my_vouchers_page.dart';
import '../../utils/api/rest_api_controller.dart';
import '../book/class/detail/argument_class_detail.dart';
import '../book/recovery/detail/arg_recovery_detail.dart';
import '../book/recovery/detail/recovery_detail_page.dart';
import '../book/trainer/detail/arg_trainer_detail.dart';
import '../book/trainer/detail/trainer_detail.dart';
import '../refcode/referral_code_page.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = RxList();
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  int page = 1;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }

  void getNotification() async {
    isLoading.value = true;
    isLoadMore.value = false;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 10};
      var response = await restApiController.get(
          endpoint: Endpoint.notification, queryParameters: queryParameter);
      notifications.value = List<NotificationModel>.from(response.data["data"]
              ["data"]
          .map((x) => NotificationModel.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value = true;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error notification ${e.message}');
    }
  }

  void getMoreNotification() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 10};
      var response = await restApiController.get(
          endpoint: Endpoint.notification, queryParameters: queryParameter);
      notifications.addAll(List<NotificationModel>.from(response.data["data"]
              ["data"]
          .map((x) => NotificationModel.fromJson(x))));
      isLoadMore.value =
          (notifications.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error notification ${e.message}');
    }
  }

  void onTapAction(
      {String? key,
      int? sessionId,
      int? sportClassId,
      String? category,
      int? teacherID,
      String? description}) {
    switch (key) {
      case 'n01':
        Get.to(() => ReferralCodePage());
        break;
      case 'n02':
        if (category == 'class') {
          Get.to(() => ClassDetailPage(), arguments: {
            ArgumentClassDetail.statusBook: StatusBook.book,
            ArgumentClassDetail.scheduleId: sessionId ?? 0,
            ArgumentClassDetail.sportsClassId: sportClassId
          });
        } else if (category == 'pt') {
          Get.to(() => TrainerDetail(),
              arguments: {ArgTrainerDetail.teacherId: teacherID});
        } else if (category == 'recovery') {
          Get.to(
              () => RecoveryDetailPage(
                    title: 'Recovery',
                  ),
              arguments: {
                ArgRecoveryDetail.sessionId: sessionId,
                ArgRecoveryDetail.sportClassId: sportClassId,
                ArgRecoveryDetail.title: 'Recovery'
              });
        } else if (category == 'wellness') {
          Get.to(
              () => RecoveryDetailPage(
                    title: 'Wellness',
                  ),
              arguments: {
                ArgRecoveryDetail.sessionId: sessionId,
                ArgRecoveryDetail.sportClassId: sportClassId,
                ArgRecoveryDetail.title: 'Wellness'
              });
        }
        break;
      case 'n03':
        Get.to(() => const UpcomingClassPage());
        break;
      case 'n04':
        Get.to(() => const PurchaseHistoryPage());
        break;
      case 'n05':
        Get.to(() => const PurchaseHistoryPage(
              index: 1,
            ));
        break;
      case 'n06':
        Get.to(() => const PurchaseHistoryPage());
        break;
      case 'n07':
        Get.to(() => const BookingHistoryPage(
              index: 1,
            ));
        break;
      case 'n08':
        Get.to(MyVouchersPage());
        break;
    }
  }

  @override
  void onClose() {
    Get.find<HomeController>().checkNotification();
    super.onClose();
  }
}
