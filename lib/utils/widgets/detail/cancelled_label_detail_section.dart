import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../colors.dart';

class CancelledLabelDetailSection extends StatelessWidget {
  const CancelledLabelDetailSection({super.key, required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1.h, color: red)),
        ),
        child: Text(
          "Cancelled",
          style: DDinExp.bold.copyWith(
            color: red,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
