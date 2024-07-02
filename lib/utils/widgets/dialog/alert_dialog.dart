import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../primary_button.dart';

class AlertPopUpDialog extends StatelessWidget {
  const AlertPopUpDialog({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final height = Get.height < 800 ? Get.height / 3 : Get.height / 3.5;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            SvgPicture.asset("assets/images/ic_alert_popup.svg"),
            const SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: DDinExp.black.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: PrimaryButton(
              elevation: 0,
              text: "OK",
              onPressed: () {
                Get.back();
              }),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
