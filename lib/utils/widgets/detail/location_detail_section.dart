import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class LocationDetailSection extends StatelessWidget {
  const LocationDetailSection(
      {super.key, required this.duration, required this.location});

  final int duration;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/images/ic_clock.svg",
          width: 20.h,
          height: 20.h,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$duration mins',
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        Visibility(
          visible: false,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/ic_location.svg",
                width: 18.h,
                height: 18.h,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                location,
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
