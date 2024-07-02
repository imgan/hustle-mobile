import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class TitleFilterSection extends StatelessWidget {
  const TitleFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (_) {
      return AnimatedBuilder(
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
                    'Filter',
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
      );
    });
  }
}