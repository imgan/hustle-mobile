import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../my_credit.dart';

class HeaderBookSection extends StatelessWidget {
  const HeaderBookSection({super.key, this.name, this.price});

  final String? name;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name ?? '',
            style: DDinExp.extraBold.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          MyCredit(
            credit: price,
          ),
        ],
      ),
    );
  }
}
