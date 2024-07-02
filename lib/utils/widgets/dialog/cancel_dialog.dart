import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../colors.dart';

class CancelDialog extends StatelessWidget {
  const CancelDialog(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.message,
      required this.onTap});

  final String title;
  final String subTitle;
  final String message;
  final VoidCallback onTap;

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
              style: DDinExp.bold.copyWith(
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
            if (message.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  textAlign: TextAlign.center,
                  message,
                  style: DDinExp.bold.copyWith(
                    color: const Color(0xFFFF2E12),
                    fontSize: 16,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PrimaryButton(
                    borderSideColor: Colors.black,
                    colorButton: Colors.white,
                    elevation: 0,
                    text: 'No',
                    onPressed: () {
                      Get.back();
                    }),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryButton(
                  text: 'Yes',
                  textColor: Colors.white,
                  colorButton: red,
                  borderSideColor: red,
                  elevation: 0,
                  isDisable: false,
                  onPressed: onTap,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
