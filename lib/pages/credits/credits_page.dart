import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/pages/credits/active/credit_active_page.dart';
import 'package:hustle_house_flutter/pages/credits/expired/credit_expired_page.dart';

import '../../utils/widgets/custom_app_bar.dart';
import '../../utils/widgets/tab/custom_tab_bar.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Credits',
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
            text: "Active",
          ),
          Tab(
            text: "Expired",
          ),
        ],
        pages: [
          CreditActivePage(),
          CreditExpiredPage(),
        ]);
  }
}
