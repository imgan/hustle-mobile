import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/widget/list_profile_menu.dart';

import '../../model/profile_menu.dart';
import '../../utils/widgets/custom_dialog.dart';
import '../profile_controller.dart';

class ProfileAccountSection extends StatelessWidget {
  ProfileAccountSection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final List<ProfileMenu> menus = [
      ProfileMenu(
          asset: 'assets/images/ic_log_out.svg',
          text: 'Log Out',
          hasCountLabel: false,
          onTap: () => Get.dialog(
                CustomDialog().alert(
                  'Log Out',
                  'Are you sure you want to log out?',
                  () {
                    Get.back();
                  },
                  () {
                    controller.logout();
                  },
                ),
              )),
      ProfileMenu(
          asset: 'assets/images/ic_trash.svg',
          text: 'Delete Account',
          hasCountLabel: false,
          onTap: () => Get.dialog(
                CustomDialog().alert('Delete Account',
                    'Are you sure you want to delete your account?', () {
                  Get.back();
                }, () {
                  controller.deleteAccount();
                },
                    message:
                        "Your credits and points will be lost. This action cannot be reverted."),
              )),
    ];
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ListProfileMenu(menus: menus));
  }
}
