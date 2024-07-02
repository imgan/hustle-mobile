import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/create_new_password_controller.dart';

import '../../utils/widgets/custom_text_form_field.dart';
import '../../utils/colors.dart';

class CreateNewPasswordPage extends StatelessWidget {
  CreateNewPasswordPage({super.key, required this.code, required this.email});

  final String code;
  final String email;

  final NewPasswordController controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<NewPasswordController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
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
                    'Create New Password',
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
                        'Your new password must be different from your previous password.',
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
                        labelText: 'New Password',
                        isObscure: true,
                        isPassword: true,
                        hintText: 'Enter your new password',
                        controller: controller.newPasswordController,
                        onChanged: (value) {
                          controller.checkPasswords();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          controller.newPasswordController.text.length < 8
                              ? Text(
                            'Must be at least 8 characters',
                            textAlign: TextAlign.start,
                            style: DDinExp.regular.copyWith(
                              color: controller.newPasswordController.text
                                  .isNotEmpty
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: 14,
                            ),
                          )
                              : Container()
                        ],
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      CustomTextFormField(
                        labelText: 'Confirm New Password',
                        hintText: 'Enter your new password',
                        isObscure: true,
                        isPassword: true,
                        controller: controller.newPasswordConfirmController,
                        onChanged: (value) {
                          controller.checkPasswords();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          controller.newPasswordController.text.isEmpty
                              ? Text(
                            'Both passwords must match',
                            style: DDinExp.regular.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          )
                              : !controller.passwordsMatch.value
                              ? Text(
                            'Password do not match',
                            style: DDinExp.regular.copyWith(
                              color: fireOrange,
                              fontSize: 14,
                            ),
                          )
                              : Container()
                        ],
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      _buttonReset(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buttonReset() {
    if (controller.isLoading.isTrue) {
      return Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }
    return PrimaryButton(
      text: 'Reset Password',
      isDisable: !controller.passwordsMatch.value,
      onPressed: () {
        controller.createNewPassword(
            email,
            controller.newPasswordController,
            controller.newPasswordConfirmController,
            code);
      },
    );
  }
}
