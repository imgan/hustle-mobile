import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';

import '../../utils/colors.dart';
import '../../utils/typography/d_din_exp.dart';
import '../../utils/widgets/empty/empty_photo.dart';
import '../editprofile/edit_profile.dart';

class ProfileInformationSection extends StatelessWidget {
  ProfileInformationSection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        margin: const EdgeInsets.only(right: 14, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 14, right: 14, bottom: 10, top: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl:
                      controller.userProfile.value?.member?.imageUrl ?? '',
                  width: 50.h,
                  height: 50.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return SizedBox(
                        width: 50.h,
                        height: 50.h,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ));
                  },
                  errorWidget: (context, url, error) {
                    final firstName =
                        controller.userProfile.value?.firstName?[0] ?? '';
                    final lastName =
                        controller.userProfile.value?.lastName?[0] ?? '';
                    return Center(
                        child: EmptyPhoto(
                      initialName: '$firstName$lastName',
                    ));
                  },
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.userProfile.value?.firstName} ${controller.userProfile.value?.lastName}",
                    style: DDinExp.extraBold.copyWith(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${controller.userProfile.value?.email}",
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.to(
                  () => EditProfilePage(),
                );
              },
              child: SvgPicture.asset(
                "assets/images/ic_edit_outline.svg",
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
