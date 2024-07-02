import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/credit.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class CreditActiveController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMoreActive = false.obs;
  RxBool isLoadMoreExpiring = false.obs;
  RxList<Credit> creditsActive = RxList();
  RxList<Credit> creditsExpiring = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int pageActive = 1;
  int pageExpiring = 1;

  @override
  void onInit() {
    getCredit();
    super.onInit();
  }

  void updateExpand(int index) {
    creditsActive[index].isExpand = !(creditsActive[index].isExpand ?? false);
    update();
  }

  void getCredit() async {
    isLoading.value = true;
    isLoadMoreActive.value = false;
    isLoadMoreExpiring.value = false;
    creditsActive.value = RxList();
    creditsExpiring.value = RxList();
    pageActive = 1;
    pageExpiring = 1;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.userCredit, queryParameters: queryParameter());
      creditsActive.value = List<Credit>.from(response.data["data"]
              ["expiringLater"]["data"]
          .map((x) => Credit.fromJson(x)));
      creditsExpiring.value = List<Credit>.from(response.data["data"]
              ["expiringSoon"]["data"]
          .map((x) => Credit.fromJson(x)));
      isLoading.value = false;
      isLoadMoreActive.value = (creditsActive.length) <
          response?.data['data']['expiringLater']['total'];
      isLoadMoreExpiring.value = (creditsExpiring.length) <
          response?.data['data']['expiringSoon']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMoreActive.value = false;
      isLoadMoreExpiring.value = false;
      update();
      log('error credits active ${e.message}');
    }
  }

  void getMoreCreditActive() async {
    isLoadMoreActive.value = false;
    pageActive++;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.userCredit, queryParameters: queryParameter());
      creditsActive.addAll(List<Credit>.from(response.data["data"]
              ["expiringLater"]["data"]
          .map((x) => Credit.fromJson(x))));
      isLoadMoreActive.value =
          (creditsActive.length) < response?.data['data']["expiringLater"]['total'];
      update();
    } on DioException catch (e) {
      isLoadMoreActive.value = false;
      update();
      log('error credit active ${e.message}');
    }
  }

  void getMoreCreditExpiring() async {
    isLoadMoreExpiring.value = false;
    pageExpiring++;
    update();
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.userCredit, queryParameters: queryParameter());
      creditsExpiring.addAll(List<Credit>.from(response.data["data"]
      ["expiringSoon"]["data"]
          .map((x) => Credit.fromJson(x))));
      isLoadMoreExpiring.value =
          (creditsExpiring.length) < response?.data['data']["expiringSoon"]['total'];
      update();
    } on DioException catch (e) {
      isLoadMoreExpiring.value = false;
      update();
      log('error credit active ${e.message}');
    }
  }


  Map<String, int> queryParameter() {
    return {'type': 1, 'page': pageActive, 'page2': pageExpiring};
  }
}
