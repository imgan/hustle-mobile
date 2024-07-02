import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/profile/widget/profile_button.dart';

import '../../model/profile_menu.dart';

class ListProfileMenu extends StatelessWidget {
  const ListProfileMenu({super.key, required this.menus});

  final List<ProfileMenu> menus;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var menu = menus[index];
          return ProfileButton(menu: menu);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 14,
          );
        },
        itemCount: menus.length);
  }
}
