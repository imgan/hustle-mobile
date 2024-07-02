import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/package_history.dart';

import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class PackageHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxList<PackageHistory> packageHistory = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int page = 1;
  int pageExpired = 1;

  @override
  void onInit() {
    getPackageHistory();
    super.onInit();
  }

  void getPackageHistory() async {
    isLoading.value = true;
    isLoadMore.value = false;
    packageHistory.value = RxList();
    page = 1;
    update();
    try {
      var queryParameter = {
        'limit': 8,
        'page': page,
        'type': 4,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      packageHistory.value = List<PackageHistory>.from(
          response.data["data"]["data"].map((x) => PackageHistory.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value =
          (packageHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error purchase history package ${e.message}');
    }
  }

  void getMorePackageHistory() async {
    isLoadMore.value = true;
    page++;
    update();
    try {
      var queryParameter = {
        'limit': 8,
        'page': page,
        'type': 4,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      packageHistory.addAll(List<PackageHistory>.from(response.data["data"]
              ["data"]
          .map((x) => PackageHistory.fromJson(x))));
      isLoadMore.value =
          (packageHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error purchase history credit valid ${e.message}');
    }
  }
}
