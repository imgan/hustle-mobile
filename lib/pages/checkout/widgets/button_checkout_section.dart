import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_package_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/widgets/primary_button.dart';

class ButtonCheckoutSection extends StatelessWidget {
  const ButtonCheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutPackageController>();
    var order = controller.order.value;
    return GetBuilder<CheckoutPackageController>(builder: (context) {
      return Container(
          padding: const EdgeInsets.only(top: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, -3),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                    Text(
                      '${order?.total} Credits',
                      style: DDinExp.bold.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              PrimaryButton(
                elevation: 0,
                sizeWidth: double.infinity,
                borderRadiusSize: 0,
                text: 'Pay Now',
                onPressed: () {
                  controller.packageMonthlyPayment();
                },
              ),
            ],
          ));
    });
  }
}
