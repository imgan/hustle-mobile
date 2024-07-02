import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';

class LabelMenu extends StatelessWidget {
  const LabelMenu(
      {super.key, required this.menu, this.onTap, this.description});

  final String menu;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menu,
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  'See all',
                  style: DDinExp.bold.copyWith(
                    color: const Color(0xFF6D6D6D),
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            description ?? '',
            style: DDinExp.regular.copyWith(fontSize: 12.sp, color: gray),
          )
        ],
      ),
    );
  }
}
