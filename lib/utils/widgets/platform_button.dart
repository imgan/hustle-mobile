import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class PlatformButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final double? sizeWidth;
  final double? sizeHeight;
  final double? borderRadiusSize;
  final Color? borderSideColor;
  final Color? colorButton;
  final Color? textColor;
  final double? fontSize;
  final double? elevation;
  final double? letterSpacing;
  final String? icon;

  const PlatformButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.sizeWidth,
      this.sizeHeight,
      this.borderRadiusSize,
      this.borderSideColor,
      this.colorButton,
      this.textColor,
      this.fontSize,
      this.elevation,
      this.letterSpacing,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(Get.width / 1.9, sizeHeight ?? 50),
          ),
          backgroundColor:
              MaterialStateProperty.all(colorButton ?? facebookColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusSize ?? 27),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: borderSideColor ?? facebookColor),
          ),
          elevation: MaterialStateProperty.all(elevation ?? 2),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon ?? ''),
          const SizedBox(
            width: 8,
          ),
          Center(
            child: Text(
              text ?? "",
              style: DDinExp.bold.copyWith(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
