import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class ItemSchedule extends StatelessWidget {
  const ItemSchedule(
      {super.key,
      required this.time,
      this.isSelected,
      this.onTap,
      required this.isDisable});

  final String time;
  final bool? isSelected;
  final VoidCallback? onTap;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable ? null : onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: _color(),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            time,
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Color _color() {
    if (isDisable) {
      return disableColor;
    }
    if (isSelected ?? false) {
      return primaryColor;
    } else {
      return Colors.white;
    }
  }
}
