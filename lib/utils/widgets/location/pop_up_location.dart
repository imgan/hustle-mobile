import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../../pages/book/class/widget/item_pop_up.dart';
import '../../colors.dart';

class PopUpLocation extends StatelessWidget {
  PopUpLocation({super.key});

  final LocationController controller = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
        backgroundColor: Colors.transparent,
        title: AnimatedBuilder(
          animation: ModalRoute.of(context)!.animation!,
          builder: (context, child) {
            final double slide = 1.0 - ModalRoute.of(context)!.animation!.value;
            return Transform(
              transform: Matrix4.translationValues(slide * 300, 0.0, 0.0),
              child: child,
            );
          },
          child: Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 14,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      controller.updateFilter();
                    },
                    child: SvgPicture.asset(
                      "assets/images/ic_back.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Locations',
                      textAlign: TextAlign.center,
                      style: DDinExp.bold.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                  )
                ],
              ),
            ),
          ),
        ),
        content: AnimatedBuilder(
          animation: ModalRoute.of(context)!.animation!,
          builder: (context, child) {
            final double slide = 1.0 - ModalRoute.of(context)!.animation!.value;
            return Transform(
              transform: Matrix4.translationValues(slide * 300, 0.0, 0.0),
              child: child,
            );
          },
          child: Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            width: Get.width,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _dropDown(
                              label: controller.locationSelected.isEmpty
                                  ? 'All Locations'
                                  : controller.locationSelected.length == 1
                                      ? '${controller.locationSelected.length} Location'
                                      : '${controller.locationSelected.length} Locations',
                              onTap: () {
                                controller.updatePopUpLocations();
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          _itemLocation(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          colorButton: Colors.white,
                          elevation: 0,
                          text: 'Reset',
                          onPressed: () {
                            controller.resetFilter();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          elevation: 0,
                          text: 'Apply',
                          onPressed: () {
                            Get.back();
                            controller.updateFilter();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _itemLocation() {
    return AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height < 800 ? Get.height / 2 : Get.height / 1.7,
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
  }

  Widget _dropDown({required VoidCallback onTap, required String label}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(right: 14, top: 10, bottom: 10, left: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_location.svg",
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: controller.isPopUpLocations.isFalse,
              child: SvgPicture.asset(
                "assets/images/ic_down.svg",
              ),
            ),
            Visibility(
              visible: controller.isPopUpLocations.isTrue,
              child: SvgPicture.asset(
                "assets/images/ic_up.svg",
              ),
            )
          ],
        ),
      ),
    );
  }
}
