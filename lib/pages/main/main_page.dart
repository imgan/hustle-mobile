import 'dart:io';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/main/main_controller.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_icon.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:upgrader/upgrader.dart';

import '../book/book_page.dart';
import '../notification/notification_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<TabItem> items = [
    const TabItem(icon: CustomIcon.home, title: 'Home'),
    const TabItem(
      icon: CustomIcon.book,
      title: 'Book',
    ),
    const TabItem(
      icon: CustomIcon.purchase,
      title: 'Purchase',
    ),
    const TabItem(
      icon: Icons.account_circle_outlined,
      title: 'Profile',
    ),
  ];

  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    OneSignal.Notifications.addClickListener((event) {
      Get.to(() => NotificationPage());
    });
    return GetBuilder<MainController>(builder: (_) {
      return UpgradeAlert(
        upgrader: Upgrader(
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
            minAppVersion: minVersion,
            showLater: false,
            showIgnore: false,
            showReleaseNotes: false),
        child: Scaffold(
          body: controller.pages[controller.index.value],
          bottomNavigationBar: _bottomBar(),
        ),
      );
    });
  }

  Widget _bottomBar() {
    return Stack(
      children: [
        Container(
          height: 1,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -3),
            )
          ]),
        ),
        BottomBarInspiredOutside(
          iconSize: 28,
          radius: 28,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 15,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
          padbottom: 0,
          padTop: 0,
          pad: 4,
          top: -60,
          items: items,
          sizeInside: 54,
          height: 60,
          backgroundColor: Colors.white,
          color: Colors.black,
          colorSelected: Colors.black,
          indexSelected: controller.index.value,
          onTap: (index) {
            controller.updateIndex(index);
            controller.updatePages(BookPage());
          },
          itemStyle: ItemStyle.circle,
          chipStyle: ChipStyle(
              notchSmoothness: NotchSmoothness.softEdge,
              background: primaryColor),
          titleStyle: DDinExp.regular
              .copyWith(color: Colors.black, fontSize: 12.sp, letterSpacing: 0),
        ),
      ],
    );
  }
}
