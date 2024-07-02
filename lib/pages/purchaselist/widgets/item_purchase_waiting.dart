import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/purchase_list.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/extension/int.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemPurchaseWaiting extends StatelessWidget {
  const ItemPurchaseWaiting(
      {super.key, required this.purchaseList, this.onTap});

  final PurchaseList purchaseList;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      purchaseList.title ?? '',
                      style: DDinExp.bold.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      purchaseList.requestTime
                              ?.formatDate(format: 'dd MMM yyyy') ??
                          '',
                      style: DDinExp.regular.copyWith(
                        color: gray,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  purchaseList.price?.formatIDR() ?? '',
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: gray1),
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  purchaseList.status ?? '',
                  style: DDinExp.regular.copyWith(
                    color: red,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: disableColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: DDinExp.regular.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
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
