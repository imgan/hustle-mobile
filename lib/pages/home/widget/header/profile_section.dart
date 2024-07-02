import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/model/user_profile.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../../utils/typography/d_din_exp.dart';
import '../../../../utils/widgets/loading/loading.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      final activeSubscribe = controller.activeSubscribe.isNotEmpty
          ? controller.activeSubscribe[0]
          : null;
      return switch (controller.profileState.value) {
        LoadingState() => Loading(
            width: Get.width / 2,
          ),
        ErrorState(error: var err) => Text(err ?? ''),
        SuccessState<UserProfile>(result: var res) => Container(
            margin: const EdgeInsets.only(left: 14, right: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hi, ${res?.firstName ?? ''}!',
                  textAlign: TextAlign.center,
                  style: DDinExp.extraBold.copyWith(
                    color: Colors.black,
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(
                  width: 14.sp,
                ),
                Visibility(
                  visible: activeSubscribe != null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.sp, vertical: 6.sp),
                    decoration: ShapeDecoration(
                      color: _bgColor(activeSubscribe?.anotherName ?? ''),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Text(
                      activeSubscribe?.anotherName ?? '',
                      textAlign: TextAlign.center,
                      style: DDinExp.bold.copyWith(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        _ => const SizedBox()
      };
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
