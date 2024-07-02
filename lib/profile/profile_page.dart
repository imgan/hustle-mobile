import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/widget/profile_account_section.dart';
import 'package:hustle_house_flutter/profile/widget/profile_activity_section.dart';
import 'package:hustle_house_flutter/profile/widget/profile_credit_section.dart';
import 'package:hustle_house_flutter/profile/widget/profile_general_section.dart';
import 'package:hustle_house_flutter/profile/widget/profile_infromation_section.dart';
import 'package:hustle_house_flutter/profile/widget/profile_status_section.dart';

import '../utils/colors.dart';
import '../utils/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller
      ..getBookingHistory()
      ..getUpcomingClass()
      ..getUserProfile()
      ..fetchMembershipCodeFromApi()
      ..getCreditHistory()
      ..getPackageHistory()
      ..getVoucherHistory()
      ..getAvailableComplimentaryVoucher()
      ..getTotalPurchaseList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Profile',
        isNoLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileInformationSection(),
            ProfileStatusSection(),
            ProfileCreditSection(),
            ProfileActivitySection(),
            ProfileGeneralSection(),
            Divider(
              color: disableColor,
              thickness: 1,
            ),
            ProfileAccountSection()
          ],
        ),
      ),
    );
  }
}
