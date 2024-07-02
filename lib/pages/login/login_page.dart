import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/login/login_controller.dart';
import 'package:hustle_house_flutter/pages/register/register_page.dart';
import 'package:hustle_house_flutter/pages/register/register_type.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/platform_button.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:upgrader/upgrader.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';
import '../forgotpassword/forgot_password.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final LoginController controller = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.emailPref.val.isNotEmpty) {
      emailController.text = controller.emailPref.val;
    }
    return UpgradeAlert(
      upgrader: Upgrader(
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          minAppVersion: minVersion,
          showLater: false,
          showIgnore: false,
          showReleaseNotes: false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<LoginController>(builder: (_) {
            return SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: -40,
                      child: SvgPicture.asset("assets/images/bg_login_top.svg"),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 46,
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      right: 14,
                      top: 120,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              labelText: 'Email',
                              hintText: 'Enter email',
                              controller: emailController,
                              onChanged: (value) {
                                controller.updateIsError(false);
                                if (controller.isClickedSignIn.isTrue) {
                                  _formKey.currentState?.validate();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            Visibility(
                                visible: controller.isError.isTrue &&
                                    controller.isEmailNotValid.isTrue,
                                child: Text(
                                  controller.errorMessage.value,
                                  style: DDinExp.regular.copyWith(
                                    color: red,
                                    fontSize: 14,
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              labelText: 'Password',
                              hintText: 'Enter password',
                              controller: passwordController,
                              isObscure: true,
                              isPassword: true,
                              onChanged: (value) {
                                controller.updateIsError(false);
                                if (controller.isClickedSignIn.isTrue) {
                                  _formKey.currentState?.validate();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            Visibility(
                                visible: controller.isError.isTrue &&
                                    controller.isEmailNotValid.isFalse,
                                child: Text(
                                  controller.errorMessage.value,
                                  style: DDinExp.regular.copyWith(
                                    color: red,
                                    fontSize: 14,
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            _rememberMe(),
                            const SizedBox(
                              height: 34,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () {
                                    Get.to(() => ForgotPasswordPage());
                                  },
                                  child: Text(
                                    'Forgot your password?',
                                    textAlign: TextAlign.center,
                                    style: DDinExp.regular.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Visibility(
                              visible: controller.isLoading.isFalse,
                              child: PrimaryButton(
                                text: 'Sign in',
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    controller.login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                  controller.isClickedSignIn.value = true;
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
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            /**
                             * TODO: Uncomment this if google & facebook approved for auth
                             */
                            // Center(
                            //   child: PlatformButton(
                            //     text: 'Login with Facebook',
                            //     icon: 'assets/images/ic_facebook.svg',
                            //     onPressed: () {
                            //       controller.handleLoginSocialMedia(
                            //           registerType: RegisterType.facebook);
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 14,
                            // ),
                            Center(
                              child: PlatformButton(
                                text: 'Sign in with Google',
                                icon: 'assets/images/ic_google.svg',
                                colorButton: Colors.white,
                                borderSideColor: Colors.white,
                                textColor: Colors.black.withOpacity(0.54),
                                onPressed: () {
                                  controller.handleLoginSocialMedia(
                                      registerType: RegisterType.google);
                                },
                              ),
                            ),
                            if (Platform.isIOS) ...[
                              const SizedBox(
                                height: 14,
                              ),
                              Center(
                                child: PlatformButton(
                                  text: 'Sign in with Apple',
                                  icon: 'assets/images/ic_apple.svg',
                                  colorButton: Colors.black,
                                  borderSideColor: Colors.black,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    controller.handleLoginSocialMedia(
                                        registerType: RegisterType.apple);
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account?',
                                  textAlign: TextAlign.center,
                                  style: DDinExp.regular.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => RegisterPage());
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: DDinExp.bold.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 20,
                      child:
                          SvgPicture.asset("assets/images/bg_login_bottom.svg"),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _rememberMe() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: controller.isCheck.value,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: Colors.black)),
            activeColor: Colors.transparent,
            checkColor: Colors.black,
            onChanged: (value) {
              controller.changeIsCheck();
            }),
        const SizedBox(
          width: 6,
        ),
        Text(
          'Remember me',
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
