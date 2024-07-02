import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/credit.dart';

import '../../../utils/colors.dart';
import '../../../utils/extension/string.dart';
import '../../../utils/typography/d_din_exp.dart';

class ItemCreditExpiring extends StatelessWidget {
  const ItemCreditExpiring({super.key, required this.credit});

  final Credit credit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: disableColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${credit.credit} Credits',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
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
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/ic_clock_outline.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${credit.expired?.formatDate(format: 'dd MMM yyyy')}',
                    style: DDinExp.regular.copyWith(
                      color: gray,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
