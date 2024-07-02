import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

class FloatingButtonText extends StatelessWidget {
  const FloatingButtonText(
      {super.key,
      required this.textButton,
      required this.onPressed,
      this.colorButton,
      this.textColor,
      this.text});

  final String textButton;
  final String? text;
  final VoidCallback onPressed;
  final Color? colorButton;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: Platform.isIOS ? 30 : 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 10,
              offset: Offset(0, -3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 14,
            ),
            Text(
              text ?? '',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            PrimaryButton(
              borderRadiusSize: 0,
              sizeWidth: double.infinity,
              elevation: 0,
              text: textButton,
              onPressed: onPressed,
              colorButton: colorButton,
              borderSideColor: colorButton,
              textColor: textColor,
            ),
          ],
        ));
  }
}
