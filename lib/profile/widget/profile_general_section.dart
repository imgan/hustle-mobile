import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/main/main_controller.dart';
import 'package:hustle_house_flutter/profile/widget/pop_up_profile_menu.dart';
import 'package:hustle_house_flutter/profile/widget/profile_menu_view.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';

import '../../model/profile_menu.dart';
import '../../pages/changepassword/changepassword.dart';
import '../../pages/membershipcard/membershipcard.dart';
import '../../pages/refcode/referral_code_page.dart';
import '../../pages/termconditions/term_conditions_page.dart';
import '../profile_controller.dart';

class ProfileGeneralSection extends StatelessWidget {
  ProfileGeneralSection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      final List<ProfileMenu> menus = [
        ProfileMenu(
            asset: 'assets/images/ic_card.svg',
            text: 'Proof of Hustlers',
            color: Colors.white,
            isDisable: controller.isActive.value == 0,
            hasCountLabel: false,
            onTap: () {
              if (controller.isActive.value == 1) {
                Get.to(() => MembershipCardPage(),
                    arguments:
                        "${controller.userProfile.value?.firstName} ${controller.userProfile.value?.lastName}");
              } else {
                Get.dialog(PopUpProfileMenu(
                    title: 'Proof of Hustlers',
                    description: controller.flagMembership.value == 2
                        ? 'You need to buy a minimum of 25 credits to access this feature.'
                        : 'You don’t have active credits',
                    command: controller.flagMembership.value == 2
                        ? 'Get your 25 credits'
                        : 'Buy Now',
                    onTap: () {
                      onTapPopUp();
                    }));
              }
            }),
        ProfileMenu(
            asset: 'assets/images/ic_reward.svg',
            text: 'Refer a Friend, Get a Reward',
            hasCountLabel: false,
            isDisable:
                controller.userProfile.value?.member?.referralCode == null,
            onTap: () {
              if (controller.userProfile.value?.member?.referralCode == null) {
                Get.dialog(PopUpProfileMenu(
                    title: 'Refer a Friend',
                    description:
                        'You need to buy a minimum of 25 credits to access this feature.',
                    command: 'Get your 25 credits',
                    onTap: () {
                      onTapPopUp();
                    }));
              } else {
                Get.to(() => ReferralCodePage());
              }
            }),
        ProfileMenu(
            asset: 'assets/images/ic_edit.svg',
            text: 'Change Password',
            hasCountLabel: false,
            onTap: () {
              Get.to(() => ChangePasswordPage());
            }),
        ProfileMenu(
            asset: 'assets/images/ic_tnc.svg',
            text: 'Terms & Conditions',
            hasCountLabel: false,
            onTap: () {
              Get.to(() => TermsConditionsPage());
            }),
      ];
      if (!controller.isShowChangePassword) {
        menus.removeAt(2);
      }
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: ProfileMenuView(menus: menus, name: 'General'));
    });
  }

  void onTapPopUp() {
    Get.back();
    Get.find<MainController>().updateIndex(2);
    if (!Get.isRegistered<CreditController>()) {
      Get.put(CreditController());
    }
    Get.find<CreditController>()
      ..updateCounterController('25')
      ..updateCurrentValue(25)
      ..updateCreditSelected(100);
  }
}
