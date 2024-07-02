import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_tab_page.dart';
import 'package:hustle_house_flutter/purchase/purchase_controller.dart';
import 'package:hustle_house_flutter/purchase/voucher/voucher_tab_page.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/tab/custom_tab_bar.dart';

class PurchasePage extends StatelessWidget {
  PurchasePage({super.key});

  final controller = Get.put(PurchaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Purchase',
        isNoDivider: true,
        isNoLeading: true,
      ),
      body: Column(
        children: [
          CustomTabBar(
              length: 2,
              tabController: controller.tabController,
              onTap: (index) {
                controller.disableVoucher();
              },
              tabs: const [
                Tab(
                  text: "Credit",
                ),
                Tab(
                  text: "Voucher",
                ),
              ],
              pages: [
                CreditTabPage(),
                voucherTabPage(),
              ])
        ],
      ),
    );
  }
}
