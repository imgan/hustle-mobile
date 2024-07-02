import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/recovery/recovery_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/widgets/content_recovery_section.dart';
import 'package:hustle_house_flutter/utils/widgets/location/pop_up_location_recovery.dart';

import '../../../utils/widgets/filter_location.dart';

class RecoveryPage extends StatelessWidget {
  RecoveryPage({super.key});

  final RecoveryController controller = Get.put(RecoveryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecoveryController>(builder: (_) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            children: [
              FilterLocation(
                text: controller
                    .locationRecoveryController.selectedLocationName.value,
                onTap: () {
                  controller.locationRecoveryController
                      .updatePopUpLocations();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  const ContentRecoverySection(),
                  PopUpLocationRecovery()
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
