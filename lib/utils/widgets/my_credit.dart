import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class MyCredit extends StatelessWidget {
  const MyCredit(
      {super.key,
      this.credit,
      this.colors = Colors.white,
      this.fontSize,
      this.fontWeight,
      this.isPackageDetail,
      this.iconSize});

  final String? credit;
  final Color? colors;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isPackageDetail;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
      decoration: ShapeDecoration(
        color: isPackageDetail ?? false ? gray1 : colors,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1, color: disableColor)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/ic_credit.svg",
            width: iconSize ?? fontSize,
            height: iconSize ?? fontSize,
          ),
          const SizedBox(width: 10),
          Text(
            isPackageDetail ?? false ? "$credit Credits" : credit ?? '0',
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize ?? 16.sp,
              fontFamily: 'D-DIN Exp',
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
