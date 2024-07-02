import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ExpandableText extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool? isExpand;

  const ExpandableText(
      {super.key,
      required this.title,
      this.onTap,
      this.isExpand,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                SvgPicture.asset(
                  isExpand ?? false
                      ? "assets/images/ic_up.svg"
                      : "assets/images/ic_down.svg",
                  height: 24.h,
                  width: 24.h,
                )
              ],
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  description,
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              secondChild: Container(),
              crossFadeState: isExpand ?? false
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            )
          ],
        ),
      ),
    );
  }
}
