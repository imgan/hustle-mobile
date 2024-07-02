import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/credit_valid_history.dart';

import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class CreditHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMoreCreditValid = false.obs;
  RxList<CreditHistory> creditValidHistory = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int page = 1;

  @override
  void onInit() {
    getCreditValidHistory();
    super.onInit();
  }

  void getCreditValidHistory() async {
    isLoading.value = true;
    isLoadMoreCreditValid.value = false;
    creditValidHistory.value = RxList();
    page = 1;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory,
          queryParameters: queryParameterPurchaseHistory(1, page));
      creditValidHistory.value = List<CreditHistory>.from(
          response.data["data"]["data"].map((x) => CreditHistory.fromJson(x)));
      isLoading.value = false;
      isLoadMoreCreditValid.value =
          (creditValidHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMoreCreditValid.value = false;
      update();
      log('error purchase history credit valid ${e.message}');
    }
  }

  void getMoreCreditValidHistory() async {
    isLoadMoreCreditValid.value = true;
    page++;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory,
          queryParameters: queryParameterPurchaseHistory(1, page));
      creditValidHistory.addAll(List<CreditHistory>.from(
          response.data["data"]["data"].map((x) => CreditHistory.fromJson(x))));
      isLoadMoreCreditValid.value =
          (creditValidHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMoreCreditValid.value = false;
      update();
      log('error purchase history credit valid ${e.message}');
    }
  }

  Map<String, int?> queryParameterPurchaseHistory(int type, int page) {
    return {
      'limit': 10,
      'page': page,
      'type': type,
    };
  }
}
