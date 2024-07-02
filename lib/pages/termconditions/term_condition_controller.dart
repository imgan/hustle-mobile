import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/termconditions/model/termcondition.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';

class TermConditionController extends GetxController {
  RxList<TermConditionData> termConditionData = RxList();
  RxBool isLoading = true.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    super.onInit();
    fetchTermConditionDataFromApi();
  }

  void fetchTermConditionDataFromApi() async {
    try {
      isLoading.value = true;
      var response =
          await restApiController.get(endpoint: Endpoint.termCondition);
      if (response.data['status'] == true) {
        termConditionData.value = List<TermConditionData>.from(
            response.data["data"].map((x) => TermConditionData.fromJson(x)));
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error fetch term condition data ${e.message}');
    }
  }
}
