import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/home/widget/header/profile_section.dart';
import 'package:hustle_house_flutter/pages/home/widget/header/search_bar.dart';

import 'header/notification_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return SizedBox(
        height: 212.h,
        child: Stack(
          children: [
            Positioned(
                right: 0, child: SvgPicture.asset("assets/images/bg_home.svg")),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Expanded(child: SearchBar()), NotificationBar()],
                ),
                ProfileSection()
              ],
            )
          ],
        ),
      );
    });
  }
}
