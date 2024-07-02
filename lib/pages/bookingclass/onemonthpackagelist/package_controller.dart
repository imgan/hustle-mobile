import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/package_first_timer.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class PackageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Package> package = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getPackage();
    super.onInit();
  }

  void getPackage() async {
    isLoading.value = true;
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.package);
      package.value = List<Package>.from(
          response.data["data"]["month_class_package"]["items"].map((x) => Package.fromJson(x)));
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error package ${e.message}');
    }
  }
}