import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/order.dart';
import '../../../utils/colors.dart';

class OrderDetailSection extends StatelessWidget {
  const OrderDetailSection({super.key, required this.order});

  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/images/ic_order.svg"),
              const SizedBox(
                width: 6,
              ),
              Text(
                'Order details',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: gray1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discount',
                style: DDinExp.thin.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                order?.totalDiscount.toString() ?? '0',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subtotal',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                '${order?.subTotal} Credits',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
        ],
      ),
    );
  }
}
