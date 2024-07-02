import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_recovery_controller.dart';

import '../../colors.dart';
import '../item_location.dart';

class PopUpLocationRecovery extends StatelessWidget {
  PopUpLocationRecovery({super.key, this.text});

  final String? text;

  final LocationRecoveryController locationRecoveryController =
      Get.find<LocationRecoveryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationRecoveryController>(builder: (context) {
      return AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Get.height / 1.7,
            ),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: disableColor),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final location = locationRecoveryController.locations[index];
                    return ItemLocation(
                      name: location.locationName ?? '',
                      isCheck: location.id ==
                          locationRecoveryController.selectedLocation.value,
                      onTap: () {
                        locationRecoveryController.updateSelectedLocation(
                            location.id ?? 0, location.locationName ?? '');
                        locationRecoveryController.updateFilter();
                        locationRecoveryController.updatePopUpLocations();
                      },
                    );
                  },
                  itemCount: locationRecoveryController.locations.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 23,
                    );
                  },
                ),
              ),
            ),
          ),
          secondChild: Container(),
          crossFadeState: locationRecoveryController.isPopUpLocations.isTrue
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond);
    });
  }
}
