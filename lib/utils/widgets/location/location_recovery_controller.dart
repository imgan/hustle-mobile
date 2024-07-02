import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/location.dart';
import '../../api/endpoint.dart';
import '../../api/rest_api_controller.dart';

class LocationRecoveryController extends GetxController {
  final Function onApplyFilter;

  RxBool isPopUpLocations = false.obs;
  RxList<Location> locations = RxList();
  RxInt selectedLocation = 0.obs;
  RxString selectedLocationName = 'Choose Location'.obs;

  final RestApiController restApiController = Get.find<RestApiController>();

  LocationRecoveryController({required this.onApplyFilter});

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  void getLocations() async {
    try {
      var response = await restApiController.get(endpoint: Endpoint.location);
      locations.value = List<Location>.from(
          response.data["data"].map((x) => Location.fromJson(x)));
      update();
    } on DioException catch (e) {
      log('error location ${e.message}');
    }
  }

  void updateSelectedLocation(int id, String name) {
    selectedLocation.value = id;
    selectedLocationName.value = name;
    update();
  }

  void updatePopUpLocations() {
    isPopUpLocations.value = !isPopUpLocations.value;
    update();
  }

  void resetFilter() {
    isPopUpLocations.value = false;
    selectedLocation.value = 0;
    selectedLocationName.value = 'Choose Location';
    update();
  }

  void updateFilter() {
    onApplyFilter();
    update();
  }


}