import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/pages/main/main_page.dart';
import 'package:hustle_house_flutter/pages/otp/otp_success_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/home_bindings.dart';

class OtpSuccessPage extends StatelessWidget {
  OtpSuccessPage({super.key, required this.isNewPassword});

  final bool isNewPassword;
  final OtpSuccessController controller = Get.put(OtpSuccessController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpSuccessController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white, // border color
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(27), // border width
                  child: Container(
                    // or ClipRRect if you need to clip the content
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // inner circle color
                    ),
                    child: FadeTransition(
                      opacity: controller.animationController,
                      child: SvgPicture.asset("assets/images/ic_checklist.svg"),
                    ), // inner content
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isNewPassword
                  ? Text(
                      'Password Changed',
                      style: DDinExp.black.copyWith(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    )
                  : Text(
                      'Verification Completed',
                      style: DDinExp.black.copyWith(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              isNewPassword
                  ? Text(
                      'Your password has been changed successfully.',
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      'Your verification was successful.',
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
              const SizedBox(
                height: 31,
              ),
              isNewPassword
                  ? PrimaryButton(
                      text: 'Sign In',
                      onPressed: () {
                        //Get.to(() => LoginPage());
                        Get.offAll(() => LoginPage(), binding: HomeBindings());
                      })
                  : PrimaryButton(
                      text: 'OK',
                      onPressed: () {
                        Get.offAll(() => MainPage(), binding: HomeBindings());
                      })
            ],
          ),
        ),
      );
    });
  }
}
