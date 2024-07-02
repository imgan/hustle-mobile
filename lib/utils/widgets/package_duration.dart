import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';
import '../extension/int.dart';

class PackageDuration extends StatelessWidget {
  const PackageDuration({super.key, this.duration, this.colors = Colors.white});

  final String? duration;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        color: gray1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1, color: disableColor)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/ic_clock_outline.svg",
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10),
          Text(
            int.parse(duration ?? '0') <= 30
                ? "$duration days"
                : "${int.parse(duration ?? '0').parseMonth()} Month",
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
