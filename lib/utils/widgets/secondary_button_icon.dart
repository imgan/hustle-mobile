import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class SecondaryButtonIcon extends StatelessWidget {
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
  final IconData? icon;

  const SecondaryButtonIcon(
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
          Size(sizeWidth ?? double.infinity, sizeHeight ?? 50.h),
        ),
        backgroundColor:
            MaterialStateProperty.all(colorButton ?? Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusSize ?? 27.h),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: borderSideColor ?? primaryColor),
        ),
        elevation: MaterialStateProperty.all(elevation ?? 2),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10))
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              text ?? "",
              style: DDinExp.bold.copyWith(
                color: textColor ?? primaryColor,
                fontSize: fontSize ?? 14.h,
              ),
            ),
            const Spacer(),
            Icon(
              icon,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
