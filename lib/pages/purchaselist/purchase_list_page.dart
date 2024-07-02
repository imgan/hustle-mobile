import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/pages/purchaselist/purchase_expired/purchase_expired_page.dart';
import 'package:hustle_house_flutter/pages/purchaselist/purchase_waiting/purchase_waiting_page.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/tab/custom_tab_bar.dart';

class PurchaseListPage extends StatelessWidget {
  const PurchaseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Pending Payment',
        isNoDivider: true,
      ),
      body: Column(
        children: [
          CustomTabBar(
              length: 2,
              scrollPhysics: const ScrollPhysics(),
              tabs: const [
                Tab(
                  text: "Waiting",
                ),
                Tab(
                  text: "Expired",
                ),
              ],
              pages: [
                PurchaseWaitingPage(),
                PurchaseExpiredPage()
              ]),
        ],
      ),
    );
  }
}
