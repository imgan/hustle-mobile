import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class DisabledPointReward extends StatelessWidget {
  final String? reward;

  const DisabledPointReward({
    super.key,
    this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1.h, color: disableColor)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/ic_award.svg",
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(width: 5.w),
          Text(
            reward ?? '',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
