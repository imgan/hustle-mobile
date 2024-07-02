import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';

import '../../utils/extension/string.dart';
import '../../utils/typography/d_din_exp.dart';

class ProfileStatusSection extends StatelessWidget {
  ProfileStatusSection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final activeSubscribe = controller.activeSubscribe.isNotEmpty
        ? controller.activeSubscribe[0]
        : null;
    return GetBuilder<ProfileController>(builder: (_) {
      return Visibility(
        visible: activeSubscribe != null,
        child: Container(
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          padding: EdgeInsets.all(5.h),
          margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: _bgColor(activeSubscribe?.anotherName ?? ''),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Text(
                  activeSubscribe?.anotherName ?? '',
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  "Valid Until: ${activeSubscribe?.expired?.formatDate(format: 'dd MMM yyyy')}",
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _bgColor(String name) {
    bool isAllAccess = name.toLowerCase().contains('class + recovery') ||
        name.toLowerCase().contains('all access');
    if (isAllAccess) {
      return const Color(0xFFD4AF38);
    }
    return const Color(0xFF4169E1);
  }
}
