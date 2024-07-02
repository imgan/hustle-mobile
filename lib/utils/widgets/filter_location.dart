import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class FilterLocation extends StatelessWidget {
  const FilterLocation({super.key, this.onTap, this.totalLocation, this.text});

  final VoidCallback? onTap;
  final int? totalLocation;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_location.svg",
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              location(),
              textAlign: TextAlign.center,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              "assets/images/ic_down.svg",
            ),
          ],
        ),
      ),
    );
  }

  String location() {
    if ((totalLocation ?? 0) == 1) {
      return '$totalLocation Location';
    } else if ((totalLocation ?? 0) > 1) {
      return '$totalLocation Locations';
    }
    return text ?? 'All Locations';
  }
}
