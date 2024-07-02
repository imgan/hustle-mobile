import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/location.dart';
import '../../api/endpoint.dart';
import '../../api/rest_api_controller.dart';

class LocationController extends GetxController {
  final Function onApplyFilter;

  RxBool isPopUpLocations = false.obs;
  RxList<Location> locations = RxList();
  RxList<int> locationSelected = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  LocationController({required this.onApplyFilter});

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

  void updateLocationSelected(int id, bool isAdd) {
    if (isAdd) {
      locationSelected.add(id);
    } else {
      locationSelected.remove(id);
    }
    update();
  }

  void updatePopUpLocations() {
    isPopUpLocations.value = !isPopUpLocations.value;
    update();
  }

  void resetFilter() {
    locationSelected.value = RxList();
    isPopUpLocations.value = false;
    update();
  }

  void updateFilter() {
    onApplyFilter();
    update();
  }


}