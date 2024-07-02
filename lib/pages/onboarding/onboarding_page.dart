import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/pages/onboarding/onboarding_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button_icon.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/secondary_button_icon.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnBoardingController>(builder: (_) {
        return Stack(
          children: [
            Image(
              image: AssetImage(controller.backgrounds[controller.page.value]),
              height: Get.height,
              width: Get.width,
              fit: BoxFit.fill,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[Color(0xFF131313), Color(0x00131313)]),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: buttonOnBoarding(),
                  ),
                ))
          ],
        );
      }),
    );
  }

  Widget buttonOnBoarding() {
    if (controller.page.value <= 1) {
      return Row(
        children: [
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    Get.offAll(() => LoginPage());
                  },
                  child: Text(
                    'Skip',
                    style: DDinExp.bold.copyWith(
                      color: primaryColor,
                      fontSize: 14.h,
                    ),
                  ))),
          Expanded(
            flex: 3,
            child: Container(),
          ),
          Expanded(
              flex: 2,
              child: SecondaryButtonIcon(
                text: 'Next',
                icon: Icons.chevron_right_rounded,
                onPressed: () {
                  controller.onChangePage();
                },
              ))
        ],
      );
    } else {
      return PrimaryButtonIcon(
        text: 'Get Started',
        icon: Icons.chevron_right_rounded,
        onPressed: () {
          Get.offAll(() => LoginPage());
        },
      );
    }
  }
}
