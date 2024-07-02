import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/credits/widgets/pop_up_credit_expiring.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/credit.dart';

class CreditExpiringSection extends StatelessWidget {
  const CreditExpiringSection({super.key, required this.credits});

  final List<Credit> credits;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(PopUpCreditExpiring());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 14, right: 14),
        child: Row(
          children: [
            Text(
              'Expiring soon',
              style: DDinExp.bold.copyWith(fontSize: 16, color: Colors.black),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.black,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
