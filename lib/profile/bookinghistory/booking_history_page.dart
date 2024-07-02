import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../utils/widgets/tab/custom_tab_bar.dart';
import 'cancelledclasspage/cancelled_class_tab.dart';
import 'completedclasspage/completed_class_tab.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key, this.index});

  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Booking History',
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
            text: "Completed",
          ),
          Tab(
            text: "Cancelled",
          ),
        ],
        pages: [
          CompletedClassTab(),
          CancelledClassTab(),
        ]);
  }
}
