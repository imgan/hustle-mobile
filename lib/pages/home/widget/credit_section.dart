import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/model/user_profile.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/widgets/loading/loading.dart';
import '../../../utils/widgets/primary_button.dart';
import '../../main/main_controller.dart';

class CreditSection extends StatelessWidget {
  const CreditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final controller = Get.find<HomeController>();

    return GetBuilder<HomeController>(builder: (_) {
      return InkWell(
        onTap: () {},
        child: Container(
          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
          padding: EdgeInsets.all(14.h),
          margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/ic_credit.svg",
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Text(
                    'Your Credits:',
                    textAlign: TextAlign.center,
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    width: 6.h,
                  ),
                  _content(controller, mainController)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              PrimaryButton(
                text: 'Top-Up Credits',
                borderRadiusSize: 10,
                onPressed: () {
                  mainController.updateIndex(2);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _content(HomeController controller, MainController mainController) {
    return switch (controller.profileState.value) {
      LoadingState() => Loading(
          height: 16.h,
          width: 16.h,
          marginHorizontal: 0,
        ),
      ErrorState(error: var err) => Text(err ?? ''),
      SuccessState<UserProfile>(result: var res) => Text(
          res?.member?.remainingCredit.toString() ?? '',
          textAlign: TextAlign.center,
          style: DDinExp.bold.copyWith(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      _ => const SizedBox()
    };
  }
}
