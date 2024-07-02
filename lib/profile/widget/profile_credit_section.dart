import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/credits/credits_page.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';

import '../../utils/colors.dart';
import '../../utils/typography/d_din_exp.dart';

class ProfileCreditSection extends StatelessWidget {
  ProfileCreditSection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Row(
        children: [
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              padding: EdgeInsets.all(14.h),
              margin:
                  const EdgeInsets.only(left: 14, right: 5, bottom: 1, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => const CreditsPage());
                },
                child: Row(
                  children: [
                    Container(
                      width: 30.h,
                      height: 30.h,
                      margin: const EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(5.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor, // inner circle color
                      ),
                      child: SvgPicture.asset(
                        "assets/images/ic_credit.svg",
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Credits',
                          textAlign: TextAlign.center,
                          style: DDinExp.regular.copyWith(
                            color: gray,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          controller.userProfile.value?.member?.remainingCredit
                                  .toString() ??
                              "0",
                          textAlign: TextAlign.center,
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              padding: EdgeInsets.all(14.h),
              margin:
                  const EdgeInsets.only(right: 14, left: 5, bottom: 1, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30.h,
                    height: 30.h,
                    margin: const EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor, // inner circle color
                    ),
                    child: SvgPicture.asset(
                      "assets/images/ic_award.svg",
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Points',
                        textAlign: TextAlign.center,
                        style: DDinExp.regular.copyWith(
                          color: gray,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        controller.userProfile.value?.member?.rewardPoints
                                .toString() ??
                            "0",
                        textAlign: TextAlign.center,
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
