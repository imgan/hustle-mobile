import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/purchase_list.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class PurchaseExpiredController extends GetxController {
  RxList<PurchaseList> purchaseList = RxList();
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  int page = 1;

  late WebViewController webViewController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getPurchaseList();
    super.onInit();
  }

  void getPurchaseList() async {
    isLoading.value = true;
    isLoadMore.value = false;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 10, 'type': 'expired'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.value = List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value = true;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

  void getMorePurchaseList() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 8, 'type': 'expired'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.addAll(List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x))));
      isLoadMore.value =
          (purchaseList.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

}
