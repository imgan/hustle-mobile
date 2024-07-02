import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/credit.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class CreditExpiredController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;

  RxList<Credit> credits = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int page = 1;

  @override
  void onInit() {
    getCredit();
    super.onInit();
  }

  void updateExpand(int index) {
    credits[index].isExpand = !(credits[index].isExpand ?? false);
    update();
  }

  void getCredit() async {
    isLoading.value = true;
    isLoadMore.value = false;
    credits.value = RxList();
    page = 1;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.userCredit, queryParameters: queryParameter());
      credits.value = List<Credit>.from(
          response.data["data"]["data"].map((x) => Credit.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value = (credits.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error credits expired ${e.message}');
    }
  }

  void getMoreCredit() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.userCredit, queryParameters: queryParameter());
      credits.addAll(List<Credit>.from(
          response.data["data"]["data"].map((x) => Credit.fromJson(x))));
      isLoadMore.value = (credits.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error credit expired ${e.message}');
    }
  }

  Map<String, int> queryParameter() {
    return {'type': 2, 'page': page};
  }
}
