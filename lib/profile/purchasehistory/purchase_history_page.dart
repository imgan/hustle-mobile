import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/credit_history_tab.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/packagehistory/package_history_tab.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../utils/widgets/tab/custom_tab_bar.dart';

class PurchaseHistoryPage extends StatelessWidget {
  final int? index;

  const PurchaseHistoryPage({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Purchase History',
        isNoDivider: true,
      ),
      body: Column(
        children: [_tabBar(context)],
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return CustomTabBar(
        length: 2,
        scrollPhysics: const ScrollPhysics(),
        tabs: const [
          Tab(
            text: "Credits",
          ),
          Tab(
            text: "Package",
          ),
        ],
        pages: [
          CreditHistoryTab(),
          PackageHistoryTab(),
        ]);
  }
}
