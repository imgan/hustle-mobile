import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_package_controller.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/button_checkout_first_section.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/checkout_discount_section.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/checkout_first_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_checkout.dart';

import '../../utils/colors.dart';
import 'widgets/item_checkout_first_section.dart';

class CheckoutFirstPackagePage extends StatelessWidget {
  CheckoutFirstPackagePage({super.key});

  final controller = Get.put(CheckoutPackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Checkout',
      ),
      body: GetBuilder<CheckoutPackageController>(builder: (context) {
        if (controller.isLoading.isTrue) {
          return const LoadingCheckout();
        }
        var package = controller.order.value?.packages?[0].package;
        var order = controller.order.value;
        return Column(
          children: [
            ItemCheckoutFirstSection(package: package),
            Divider(thickness: 10, color: gray1),
            const CheckoutDiscountSection(),
            Divider(thickness: 10, color: gray1),
            CheckoutFirstDetailSection(
              order: order,
            ),
            const Spacer(),
            const ButtonCheckoutFirstSection()
          ],
        );
      }),
    );
  }
}
