import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/profile_menu.dart';
import '../../utils/typography/d_din_exp.dart';
import 'list_profile_menu.dart';

class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({super.key, required this.menus, required this.name});

  final List<ProfileMenu> menus;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        ListProfileMenu(menus: menus)
      ],
    );
  }
}
