import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/purchase_list.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/extension/int.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemPurchase extends StatelessWidget {
  const ItemPurchase({super.key, required this.purchaseList});

  final PurchaseList purchaseList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                purchaseList.title ?? '',
                style: DDinExp.bold.copyWith(
                  color: gray,
                  fontSize: 20,
                ),
              ),
              Text(
                purchaseList.requestTime?.formatDate(format: 'dd MMM yyyy') ??
                    '',
                style: DDinExp.regular.copyWith(
                  color: gray,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                purchaseList.price?.formatIDR() ?? '',
                style: DDinExp.bold.copyWith(
                  color: gray,
                  fontSize: 14,
                ),
              ),
              Text(
                purchaseList.status?.capitalizeFirst ?? '',
                style: DDinExp.regular.copyWith(
                  color: gray,
                  fontSize: 14,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
