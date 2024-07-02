import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_package_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../voucher/argument_use_voucher.dart';
import '../../voucher/use_vouceher_page.dart';

class CheckoutDiscountSection extends StatelessWidget {
  const CheckoutDiscountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutPackageController>();
    return GetBuilder<CheckoutPackageController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: InkWell(
          onTap: () {
            Get.to(
                () => UseVoucherPage(
                      title: 'Discount',
                    ),
                arguments: {
                  ArgumentUseVoucher.type: 1,
                  ArgumentUseVoucher.currentRoute: Get.currentRoute,
                  ArgumentUseVoucher.promoCodeCategory: 'first time',
                  ArgumentUseVoucher.usedVoucher: controller.discountCode.value,
                  ArgumentUseVoucher.hideQuery: controller.isHideQuery
                });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Discount",
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      textAlign: TextAlign.end,
                      controller.discountCode.value,
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black,
                size: 28,
              ),
            ],
          ),
        ),
      );
    });
  }
}
