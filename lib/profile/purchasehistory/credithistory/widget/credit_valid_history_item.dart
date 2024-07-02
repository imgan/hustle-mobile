import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/credit_valid_history.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

import '../../../../utils/colors.dart';

class CreditValidHistoryItem extends StatelessWidget {
  const CreditValidHistoryItem({super.key, this.creditValidHistory});

  final CreditHistory? creditValidHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 1, top: 14),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: disableColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${creditValidHistory?.name}",
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: gray3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              creditValidHistory?.transactionDate
                      ?.formatDate(format: 'dd MMM yyyy') ??
                  '',
              style: DDinExp.regular.copyWith(
                color: gray,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
