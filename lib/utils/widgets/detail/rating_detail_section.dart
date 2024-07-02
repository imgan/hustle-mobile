import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class RatingDetailSection extends StatelessWidget {
  const RatingDetailSection(
      {super.key,
      required this.isVisible,
      required this.averageRating,
      required this.totalRating});

  final bool isVisible;
  final double averageRating;
  final int totalRating;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Icon(
              Icons.star,
              color: Colors.black,
              size: 14.h,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '($totalRating)',
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
