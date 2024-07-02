import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/credit.dart';

import '../../../utils/colors.dart';
import '../../../utils/extension/string.dart';
import '../../../utils/typography/d_din_exp.dart';

class ItemCredit extends StatelessWidget {
  const ItemCredit(
      {super.key, required this.credit, required this.onTap, this.isExpired});

  final Credit credit;
  final VoidCallback onTap;
  final bool? isExpired;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
      padding: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: disableColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${credit.creditStartOrder} Credits',
                      style: DDinExp.bold.copyWith(
                        color: isExpired ?? false ? gray : Colors.black,
                        fontSize: 20,
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
                          SvgPicture.asset(
                              "assets/images/ic_clock_outline.svg"),
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
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: gray1,
            height: 0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text(
                        'Details',
                        style: DDinExp.regular
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      SvgPicture.asset(
                        credit.isExpand ?? false
                            ? "assets/images/ic_up.svg"
                            : "assets/images/ic_down.svg",
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: credit.isExpand ?? false,
                  child: Text(
                    (isExpired ?? false)
                        ? 'Used: ${credit.creditUsed}'
                        : 'Available: ${(credit.creditStartOrder ?? 0) - (credit.creditUsed ?? 0)}',
                    style: DDinExp.regular
                        .copyWith(color: Colors.black, fontSize: 14),
                  ),
                ),
                Visibility(
                  visible: (credit.isExpand ?? false) && (isExpired ?? false),
                  child: Text(
                    'Expired: ${(credit.creditStartOrder ?? 0) - (credit.creditUsed ?? 0)}',
                    style: DDinExp.regular
                        .copyWith(color: Colors.black, fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
