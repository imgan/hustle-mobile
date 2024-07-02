import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_recovery_controller.dart';

import '../../../model/location.dart';

class LocationWellnessController extends GetxController {
  final Function onApplyFilter;

  RxBool isPopUpLocations = false.obs;
  RxList<Location> locations = RxList();
  RxInt selectedLocation = 0.obs;
  RxString selectedLocationName = 'Choose Location'.obs;

  final LocationRecoveryController locationRecoveryController =
      Get.find<LocationRecoveryController>();

  LocationWellnessController({required this.onApplyFilter});

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  void getLocations() {
    locations.value = locationRecoveryController.locations;
    update();
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
