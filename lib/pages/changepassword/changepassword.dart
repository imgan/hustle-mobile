import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/changepassword/change_password_controller.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/forgot_password.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Change Password',
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ChangePasswordController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        labelText: 'Current Password',
                        hintText: 'Enter password',
                        controller: controller.oldPasswordController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          controller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: controller.isPasswordTrue.value,
                        //visible: false,
                        child: Text(
                          'Wrong password',
                          style: DDinExp.regular.copyWith(
                            color: red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'New Password',
                        hintText: 'Enter password',
                        controller: controller.newPasswordController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          controller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 21),
                      CustomTextFormField(
                        labelText: 'Confirm New Password',
                        hintText: 'Enter password',
                        controller: controller.newPasswordConfirmController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          controller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ForgotPasswordPage());
                        },
                        child: Text(
                          'Forgot your password?',
                          style: DDinExp.regular.copyWith(
                              color: bgColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 30),
                      Visibility(
                        visible: controller.isLoading.isFalse,
                        replacement: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  colorButton: Colors.white,
                                  borderSideColor: Colors.black,
                                  text: 'Cancel',
                                  borderRadiusSize: 30,
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              const SizedBox(width: 9),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Save',
                                  //isDisable: true,
                                  isDisable: !controller.isValidPasswords.value,
                                  borderRadiusSize: 30,
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    controller.createNewPassword();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
