import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isNoLeading;
  final bool? isNoDivider;
  final VoidCallback? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.isNoLeading,
      this.isNoDivider,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: DDinExp.bold.copyWith(
          color: Colors.black,
          fontSize: 16.sp,
        ),
      ),
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      leading: !(isNoLeading ?? false)
          ? IconButton(
              icon: Icon(
                Icons.chevron_left_outlined,
                size: 28.h,
              ),
              color: Colors.black,
              onPressed: onPressed ??
                  () {
                    Get.back();
                  },
            )
          : null,
      bottom: !(isNoDivider ?? false)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight / 4),
              child: Divider(thickness: 10.h, color: gray1),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      !(isNoDivider ?? false) ? (kToolbarHeight * 1.25).h : kToolbarHeight.h);
}
