import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/booking_history.dart';

import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class BookingCancelledController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxList<BookingHistory> bookingHistory = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int page = 1;

  @override
  void onInit() {
    getBookingHistoryCancelled();
    super.onInit();
  }

  void getBookingHistoryCancelled() async {
    isLoading.value = true;
    isLoadMore.value = false;
    bookingHistory.value = RxList();
    page = 1;
    update();
    try {
      final queryParameter = {'isFuture': 0, 'limit': 8, 'page': page};
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCancelled,
          queryParameters: queryParameter);
      bookingHistory.value = List<BookingHistory>.from(
          response.data["data"]["data"].map((x) => BookingHistory.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value =
          (bookingHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error booking history cancelled ${e.message}');
    }
  }

  void getMoreBookingHistoryCancelled() async {
    isLoadMore.value = true;
    page++;
    update();
    try {
      final queryParameter = {'isFuture': 0, 'limit': 8, 'page': page};
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCancelled,
          queryParameters: queryParameter);
      bookingHistory.addAll(List<BookingHistory>.from(response.data["data"]
              ["data"]
          .map((x) => BookingHistory.fromJson(x))));
      isLoadMore.value =
          (bookingHistory.length) < response?.data['data']['total'];
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error booking cancel completed ${e.message}');
    }
  }
}
