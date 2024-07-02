import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class ItemSpecialization extends StatelessWidget {
  const ItemSpecialization({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3.5,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: gray2),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
