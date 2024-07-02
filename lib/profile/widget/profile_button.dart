import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/profile_menu.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../utils/colors.dart';

class ProfileButton extends StatelessWidget {
  final ProfileMenu menu;

  const ProfileButton({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.h),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: menu.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: menu.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              menu.asset,
              height: 24.h,
              width: 24.w,
              colorFilter: menu.isDisable ?? false
                  ? ColorFilter.mode(gray2, BlendMode.srcIn)
                  : null,
            ),
            SizedBox(width: 10.w),
            Text(
              menu.text,
              textAlign: TextAlign.center,
              style: DDinExp.regular.copyWith(
                color: menu.isDisable ?? false ? gray2 : Colors.black,
                fontSize: 14.sp,
              ),
            ),
            const Spacer(),
            if (menu.hasCountLabel != false)
              Container(
                width: 30.h,
                height: 30.h,
                margin: const EdgeInsets.only(right: 8),
                padding: EdgeInsets.all(6.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor, // inner circle color
                ),
                child: Text(
                  menu.number ?? '',
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            Icon(
              menu.isDisable ?? false
                  ? Icons.info_outline_rounded
                  : Icons.chevron_right_rounded,
              color: Colors.black,
              size: menu.isDisable ?? false ? 24.h : 28.h,
            ),
          ],
        ),
      ),
    );
  }
}
