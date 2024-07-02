import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_credit_controller.dart';
import 'package:hustle_house_flutter/utils/extension/int.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_checkout.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/primary_button.dart';
import '../voucher/argument_use_voucher.dart';
import '../voucher/use_vouceher_page.dart';

class CheckoutCreditPage extends StatelessWidget {
  CheckoutCreditPage({super.key});

  final CheckoutCreditController controller =
      Get.put(CheckoutCreditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Checkout',
      ),
      body: GetBuilder<CheckoutCreditController>(builder: (_) {
        final order = controller.order.value;
        final total = controller.getTotal();
        if (controller.isLoading.isTrue) {
          return const LoadingCheckout();
        }
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order?.orderCredit?[0].nameOrder ?? '',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${order?.orderCredit?[0].price?.formatIDR()}/credit',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(children: [
                    WidgetSpan(
                      child: SvgPicture.asset(
                        "assets/images/ic_clock_outline.svg",
                      ),
                    ),
                    TextSpan(
                      text:
                          " Expired in: ${order?.orderCredit?[0].expiry ?? '0'} Days",
                    ),
                  ])),
                ],
              ),
            ),
            Divider(thickness: 10, color: gray1),
            Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(
                  left: 14, right: 5, bottom: 10, top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(
                      () => UseVoucherPage(
                            title: 'Discount',
                          ),
                      arguments: {
                        ArgumentUseVoucher.type: 1,
                        ArgumentUseVoucher.currentRoute: Get.currentRoute,
                        ArgumentUseVoucher.promoCodeCategory: 'credit',
                        ArgumentUseVoucher.usedVoucher:
                            controller.discountCode.value,
                        ArgumentUseVoucher.hideQuery: controller.isHideQuery
                      });
                },
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(0),
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
                  ],
                ),
              ),
            ),
            Divider(thickness: 10, color: gray1),
            Container(
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
                        style: DDinExp.regular.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        order?.totalDiscount?.formatIDR() ?? '0',
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
                        order?.subTotal?.formatIDR() ?? '0',
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
            ),
            const Spacer(),
            Container(
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
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: DDinExp.bold.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            total.formatIDR() ?? '0',
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
                        controller.paymentMidtrans();
                      },
                    ),
                  ],
                ))
          ],
        );
      }),
    );
  }
}