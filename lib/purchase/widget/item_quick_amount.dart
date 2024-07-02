import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class ItemAutoFill extends StatelessWidget {
  const ItemAutoFill(
      {super.key, required this.amount, this.onTap, this.isSelected});

  final String amount;
  final VoidCallback? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: isSelected ?? false ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            amount,
            style:  DDinExp.regular.copyWith(
              color: isSelected ?? false ? Colors.white : Colors.black,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
