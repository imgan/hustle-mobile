import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/trainer.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class TrainerController extends GetxController {
  RxList<Trainer> trainers = RxList();
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  int page = 1;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getTrainer();
    super.onInit();
  }

  Future<void> getTrainer() async {
    isLoading.value = true;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 18};
      var response = await restApiController.get(
          endpoint: Endpoint.teacher, queryParameters: queryParameter);
      trainers.value = List<Trainer>.from(
          response.data["data"]["data"].map((x) => Trainer.fromJson(x)));
      isLoadMore.value = (trainers.length) < response?.data['data']['total'];
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error trainer ${e.message}');
    }
  }

  void getMoreTrainer() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 18};
      var response = await restApiController.get(
          endpoint: Endpoint.teacher, queryParameters: queryParameter);
      trainers.addAll(List<Trainer>.from(
          response.data["data"]["data"].map((x) => Trainer.fromJson(x))));
      isLoadMore.value = (trainers.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error trainer ${e.message}');
    }
  }
}
