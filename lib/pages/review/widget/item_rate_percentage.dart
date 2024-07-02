import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/colors.dart';

class ItemRatePercentage extends StatelessWidget {
  const ItemRatePercentage(
      {super.key, required this.number, required this.percent});

  final String number;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          textAlign: TextAlign.center,
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 8.5,
            percent: percent,
            barRadius: const Radius.circular(10),
            progressColor: Colors.black,
            backgroundColor: gray1,
          ),
        )
      ],
    );
  }
}
