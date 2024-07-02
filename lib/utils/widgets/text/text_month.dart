import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class TextMonth extends StatelessWidget {
  const TextMonth({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: DDinExp.bold.copyWith(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    );
  }
}
