import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class PrimaryButton extends StatelessWidget {
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
  final bool? isDisable;
  final bool? isLoading;

  const PrimaryButton(
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
      this.isDisable,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }
    return ElevatedButton(
      onPressed: isDisable ?? false ? null : onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(sizeWidth ?? double.infinity, sizeHeight ?? 50.h),
        ),
        backgroundColor: MaterialStateProperty.all(
            !(isDisable ?? false) ? colorButton ?? primaryColor : disableColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusSize ?? 27.h),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
              color: !(isDisable ?? false)
                  ? borderSideColor ?? primaryColor
                  : disableColor),
        ),
        elevation: MaterialStateProperty.all(elevation ?? 2),
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: DDinExp.bold.copyWith(
            color: !(isDisable ?? false) ? textColor ?? Colors.black : gray,
            fontSize: fontSize ?? 14.h,
          ),
        ),
      ),
    );
  }
}
