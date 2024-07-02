import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemDate extends StatelessWidget {
  const ItemDate({super.key, required this.date, this.isSelected, this.onTap});

  final String date;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          color: isSelected ?? false ? primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            date,
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
