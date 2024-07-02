import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class/class_type_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_title.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/loading/loading.dart';
import '../../onemonthpackagelist/package_page.dart';

class MonthlyPackageSection extends StatelessWidget {
  const MonthlyPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassTypeController>();
    return GetBuilder<ClassTypeController>(builder: (_) {
      if (controller.isLoadingMonthPackage.isTrue) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          child: const Loading(
            height: 145,
          ),
        );
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => const PackagePage());
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitle(
                          text: controller.title.value,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(controller.description.value,
                            style: DDinExp.regular.copyWith(
                              color: Colors.black,
                              fontSize: 12,
                            ))
                      ]),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: primaryDarkColor2,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}