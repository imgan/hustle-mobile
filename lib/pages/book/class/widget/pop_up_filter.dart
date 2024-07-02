import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/class_filter_section.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/dropdown_filter_section.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/location_filter_section.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import 'title_filter_section.dart';

class PopUpFilter extends StatelessWidget {
  PopUpFilter({
    super.key,
  });

  final BookClassController controller = Get.find<BookClassController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookClassController>(builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
        backgroundColor: Colors.transparent,
        title: const TitleFilterSection(),
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
                          /**
                           * TODO: Temporary hide filter location
                           */
                          // _label(text: 'Locations'),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // DropDownFilterSection(
                          //     isLocation: true,
                          //     label: controller.locationSelected.isEmpty
                          //         ? 'All Locations'
                          //         : controller.locationSelected.length == 1
                          //             ? '${controller.locationSelected.length} Location'
                          //             : '${controller.locationSelected.length} Locations',
                          //     onTap: () {
                          //       controller.updatePopUpLocations();
                          //       controller.updatePopUpClass(value: false);
                          //     }),
                          const LocationFilterSection(),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                              visible: controller.isPopUpLocations.isFalse,
                              child: _label(text: 'Classes')),
                          const SizedBox(
                            height: 5,
                          ),
                          Visibility(
                              visible: controller.isPopUpLocations.isFalse,
                              child: DropDownFilterSection(
                                  label: textDropDown(),
                                  onTap: () {
                                    controller.updatePopUpClass();
                                  })),
                          const ClassFilterSection(),
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
                            controller.updateClasses();
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

  Widget _label({required String text}) {
    return Text(
      text,
      style: DDinExp.bold.copyWith(
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }

  String textDropDown() {
    int totalSelected = controller.classSelected.length;
    if (totalSelected == 1) {
      return '$totalSelected Class';
    } else if (totalSelected > 1) {
      return '$totalSelected Classes';
    }
    return 'All Classes';
  }
}
