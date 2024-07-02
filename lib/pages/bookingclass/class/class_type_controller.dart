import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/class.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class ClassTypeController extends GetxController {
  RxBool isLoadingBanner = true.obs;
  RxBool isLoadingMonthPackage = true.obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxList<SportClass> classes = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getClasses();
    getPackage();
    super.onInit();
  }

  void getClasses() async {
    isLoadingBanner.value = true;
    update();
    try {
      final queryParameter = {
        'category': 'class',
      };
      var response = await restApiController.get(
          endpoint: Endpoint.sportsClass, queryParameters: queryParameter);
      classes.value = List<SportClass>.from(
              response.data["data"].map((x) => SportClass.fromJson(x)));
      isLoadingBanner.value = false;
      update();
    } on DioException catch (e) {
      isLoadingBanner.value = false;
      update();
      log('error classes ${e.message}');
    }
  }

  void getPackage() async {
    isLoadingMonthPackage.value = true;
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.package);
      isLoadingMonthPackage.value = false;
      title.value = response?.data['data']['month_class_package']['title'];
      description.value =
          response?.data['data']['month_class_package']['description'];
      update();
    } on DioException catch (e) {
      isLoadingMonthPackage.value = false;
      update();
      log('error package ${e.message}');
    }
  }
}
