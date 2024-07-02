import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/book_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_page.dart';
import 'package:hustle_house_flutter/pages/book/recovery/recovery_page.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book_trainer_page.dart';
import 'package:hustle_house_flutter/pages/book/wellness/wellness_page.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/tab/custom_tab_bar.dart';

class BookPage extends StatelessWidget {
  BookPage({super.key});

  final controller = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Schedule',
        isNoLeading: true,
        isNoDivider: true,
      ),
      body: Column(
        children: [
          CustomTabBar(
              length: 4,
              tabController: controller.tabController,
              onTap: (index) {
                controller.disableTab();
              },
              isScrollable: true,
              showBottomDivider: true,
              tabs: [
                SizedBox(
                  width: Get.width / 4,
                  child: const Tab(
                    text: "Class",
                  ),
                ),
                SizedBox(
                  width: Get.width / 4,
                  child: const Tab(
                    text: "PT",
                  ),
                ),
                SizedBox(
                  width: Get.width / 4,
                  child: const Tab(
                    text: "Recovery",
                  ),
                ),
                SizedBox(
                  width: Get.width / 4,
                  child: const Tab(
                    text: "Wellness",
                  ),
                )
              ],
              pages: [
                BookClassPage(),
                BookTrainerPage(),
                RecoveryPage(),
                WellnessPage()
              ])
        ],
      ),
    );
  }
}
