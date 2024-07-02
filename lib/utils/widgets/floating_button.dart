import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key,
    required this.text,
    required this.onPressed,
    this.colorButton,
    this.textColor,
    this.borderColor,
    this.isDisable});

  final String text;
  final VoidCallback onPressed;
  final Color? colorButton;
  final Color? textColor;
  final Color? borderColor;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: Platform.isIOS ? 30 : 10),
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
        child: PrimaryButton(
          elevation: 0,
          text: text,
          onPressed: onPressed,
          colorButton: colorButton,
          borderSideColor: borderColor,
          textColor: textColor,
          isDisable: isDisable,
        ));
  }
}
