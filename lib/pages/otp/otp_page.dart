import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/change_number_page.dart';
import 'package:hustle_house_flutter/pages/otp/otp_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/typography/oswald.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';
import 'arg_change_number.dart';

class OtpPage extends StatelessWidget {
  OtpPage(
      {super.key,
      required this.otpValue,
      required this.isEmail,
      this.email,
      this.isShowChangeNumber});

  final String otpValue;
  final bool isEmail;
  final String? email;
  final bool? isShowChangeNumber;

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 36,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          )),
      body: GetBuilder<OtpController>(builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'OTP Verification',
                style: DDinExp.black.copyWith(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter the OTP sent to ',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Visibility(
                      visible: !(isShowChangeNumber ?? false),
                      child: Text(
                        otpValue,
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isShowChangeNumber ?? false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      otpValue,
                      style: DDinExp.bold.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      ' via WhatsApp',
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ChangeNumberPage(), arguments: {
                          ArgChangeNumberOtp.email:
                              controller.arguments[ArgChangeNumberOtp.email],
                          ArgChangeNumberOtp.userID:
                              controller.arguments[ArgChangeNumberOtp.userID],
                        });
                      },
                      child: Text(
                        'Change',
                        style: DDinExp.regular.copyWith(
                            color: blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              SizedBox(
                width: 325,
                child: PinCodeTextField(
                  length: 5,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  boxShadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  pinTheme: PinTheme.defaults(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    selectedColor: Colors.white,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    activeColor: Colors.white,
                  ),
                  textStyle: Oswald.bold.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  onCompleted: (v) async {
                    controller.changeStateButtonDisable(false);
                  },
                  onChanged: (value) {
                    controller.changeStateButtonDisable(true);
                    controller.updateCode(value);
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.labelOtp.value,
                    textAlign: TextAlign.center,
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Visibility(
                    visible: controller.isTimerStop.isTrue,
                    child: InkWell(
                      onTap: () {
                        if (isEmail) {
                          controller.resendOtpEmail(email: otpValue);
                        } else {
                          controller.resendOtp(email: email ?? '');
                        }
                      },
                      child: Text(
                        'RESEND OTP',
                        textAlign: TextAlign.center,
                        style: DDinExp.bold.copyWith(
                          color: blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.isTimerStop.isFalse,
                    child: Text(
                      '${controller.second.value} Second',
                      textAlign: TextAlign.center,
                      style: DDinExp.regular.copyWith(
                        color: blue,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 31,
              ),
              Visibility(
                visible: controller.isLoading.isFalse,
                child: PrimaryButton(
                  text: 'Verify',
                  isDisable: controller.isDisableButton.value,
                  elevation: 0,
                  onPressed: () {
                    if (isEmail) {
                      // go to new password
                      controller.verifyOtpEmail(email: otpValue);
                    } else {
                      controller.verifyOtp(email: email ?? '');
                    }
                  },
                ),
              ),
              Visibility(
                visible: controller.isLoading.isTrue,
                child: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
