import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class DropDownFilterSection extends StatelessWidget {
  const DropDownFilterSection(
      {super.key, required this.onTap, this.isLocation, required this.label});

  final VoidCallback onTap;
  final bool? isLocation;
  final String label;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (context) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
              right: 14,
              top: 10,
              bottom: 10,
              left: controller.isPopUpLocations.isTrue ? 14 : 4),
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: controller.isPopUpLocations.isTrue ? 24 : 0,
                child: SvgPicture.asset(
                  "assets/images/ic_location.svg",
                ),
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
    });
  }
}
