import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_package_controller.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/button_checkout_section.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/item_checkout_section.dart';
import 'package:hustle_house_flutter/pages/checkout/widgets/order_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_checkout.dart';

import '../../utils/colors.dart';

class CheckoutPackagePage extends StatelessWidget {
  CheckoutPackagePage({super.key});

  final controller = Get.put(CheckoutPackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Checkout',
      ),
      body: GetBuilder<CheckoutPackageController>(builder: (_) {
        if (controller.isLoading.isTrue) {
          return const LoadingCheckout();
        }
        var package = controller.order.value?.packages?[0].package;
        var order = controller.order.value;
        return Column(
          children: [
            ItemCheckoutSection(package: package),
            Divider(thickness: 10, color: gray1),
            OrderDetailSection(order: order),
            const Spacer(),
            const ButtonCheckoutSection()
          ],
        );
      }),
    );
  }
}
