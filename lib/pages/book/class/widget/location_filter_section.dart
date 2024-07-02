import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';

import '../../../../utils/colors.dart';
import 'item_pop_up.dart';

class LocationFilterSection extends StatelessWidget {
  const LocationFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (context) {
      return AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Get.height / 1.7,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isPopUpLocations.isTrue ? 5 : 0),
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
                    final location = controller.locations[index];
                    return ItemFilter(
                      location: location.locationName ?? '',
                      isCheck: controller.locationSelected.contains(location.id),
                      onChanged: (value) {
                        controller.updateLocationSelected(
                            location.id ?? 0, value ?? false);
                      },
                    );
                  },
                  itemCount: controller.locations.length,
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
          crossFadeState: controller.isPopUpLocations.isTrue
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond);
    });
  }
}
