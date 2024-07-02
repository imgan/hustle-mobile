import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemScheduleWellness extends StatelessWidget {
  const ItemScheduleWellness(
      {super.key, required this.name, this.isSelected, this.onTap});

  final String name;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: isSelected ?? false,
            child: SvgPicture.asset(
              "assets/images/ic_checklist.svg",
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
