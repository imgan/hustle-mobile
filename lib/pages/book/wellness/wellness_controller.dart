import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_wellness_controller.dart';

import '../../../model/recovery.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class WellnessController extends GetxController {
  Rx<Result> wellnessState = Rx(LoadingState());

  late LocationWellnessController locationWellnessController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    locationWellnessController =
        Get.put(LocationWellnessController(onApplyFilter: () {
      getWellness();
    }));
    getWellness();
    super.onInit();
  }

  Future<void> getWellness() async {
    wellnessState.value = LoadingState();
    update();
    try {
      final queryParameter = {
        'location': locationWellnessController.selectedLocation.value
      };
      var response = await restApiController.get(
          endpoint: Endpoint.wellness, queryParameters: queryParameter);
      if (response?.statusCode == 200) {
        final wellness = List<Recovery>.from(
            response?.data["data"].map((x) => Recovery.fromJson(x)));
        if (wellness.isEmpty) {
          wellnessState.value = EmptyState();
        } else {
          wellnessState.value = SuccessState<List<Recovery>>(wellness);
        }
      } else {
        wellnessState.value = ErrorState(response?.data["message"]);
      }
      update();
    } on DioException catch (e) {
      wellnessState.value = ErrorState(e.message);
      update();
      log('error wellness ${e.message}');
    }
  }
}
