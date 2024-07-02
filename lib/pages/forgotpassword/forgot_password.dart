import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/forgot_password_controller.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<ForgotPasswordController>(builder: (_) {
        return SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 13, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: SvgPicture.asset(
                              'assets/images/chevron-left-outline.svg'))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Reset Password',
                  style: DDinExp.black.copyWith(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 15),
                  child: Column(children: [
                    Text(
                      'Enter the email associated with your account and we will send an email to reset your password.',
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    CustomTextFormField(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      controller: _emailController,
                      onChanged: (value) {
                        controller.validateEmail(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        controller.isHasEmail.isFalse
                            ? Text(
                                'Email not found',
                                style: DDinExp.regular.copyWith(
                                  color: red,
                                  fontSize: 14,
                                ),
                              )
                            : Container()
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: !controller.isLoading.value,
                              child: PrimaryButton(
                                text: 'Send Email',
                                isDisable: !controller.isValidEmail.value,
                                onPressed: () {
                                  controller.checkEmail(_emailController.text);
                                },
                              ),
                            ),
                            controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: primaryColor,
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
