import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_recovery_controller.dart';

import '../../../model/recovery.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class RecoveryController extends GetxController {
  Rx<Result> recoveryState = Rx(LoadingState());

  late LocationRecoveryController locationRecoveryController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    locationRecoveryController =
        Get.put(LocationRecoveryController(onApplyFilter: () {
      getRecovery();
    }));
    locationRecoveryController.resetFilter();
    getRecovery();
    super.onInit();
  }

  Future<void> getRecovery() async {
    recoveryState.value = LoadingState();
    update();
    try {
      final queryParameter = {
        'location': locationRecoveryController.selectedLocation.value
      };
      var response = await restApiController.get(
          endpoint: Endpoint.recovery, queryParameters: queryParameter);
      if (response?.statusCode == 200) {
        final recoveries = List<Recovery>.from(
            response?.data["data"].map((x) => Recovery.fromJson(x)));
        if (recoveries.isEmpty) {
          recoveryState.value = EmptyState();
        } else {
          recoveryState.value = SuccessState<List<Recovery>>(recoveries);
        }
      } else {
        recoveryState.value = ErrorState(response?.data["message"]);
      }
      update();
    } on DioException catch (e) {
      recoveryState.value = ErrorState(e.message);
      update();
      log('error recovery ${e.message}');
    }
  }
}
