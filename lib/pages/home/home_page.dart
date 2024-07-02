import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/widget/banner_section.dart';
import 'package:hustle_house_flutter/pages/home/widget/classes_section.dart';
import 'package:hustle_house_flutter/pages/home/widget/credit_section.dart';
import 'package:hustle_house_flutter/pages/home/widget/home_header.dart';
import 'package:hustle_house_flutter/pages/home/widget/rating_section.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>().getUserProfile();
    Get.find<HomeController>().checkNotification();
    Get.find<ProfileController>().getBookingHistory();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () {
            return Get.find<HomeController>().refreshHome();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeHeader(),
                const CreditSection(),
                const RatingSection(),
                const BannerSection(),
                const ClassesSection(),
                /**
                 * For phase two
                 * VoucherSection()
                 */
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
