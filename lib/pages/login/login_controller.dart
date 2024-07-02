import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hustle_house_flutter/pages/main/main_page.dart';
import 'package:hustle_house_flutter/pages/otp/arg_change_number.dart';
import 'package:hustle_house_flutter/pages/otp/otp_page.dart';
import 'package:hustle_house_flutter/pages/register/register_controller.dart';
import 'package:hustle_house_flutter/pages/register/register_type.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';
import 'package:hustle_house_flutter/utils/home_bindings.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/widgets/dialog/alert_dialog.dart';

class LoginController extends GetxController {
  RxBool isCheck = false.obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxBool isEmailNotValid = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isClickedSignIn = false.obs;

  RestApiController restApiController = Get.find<RestApiController>();
  var emailPref = Get.find<MyPref>().email;
  var accessToken = Get.find<MyPref>().accessToken;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'openid', 'profile'],
  );

  void login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      isEmailNotValid.value = false;
      update();
      var parameter = {"email": email, "password": password};
      var response = await restApiController.post(
          endpoint: Endpoint.login, data: parameter);

      isLoading.value = false;
      if (response?.statusCode == 200) {
        if (response.data['user']['member']['isVerified'] == false) {
          update();
          return Get.to(
              () => OtpPage(
                    otpValue: response.data['user']['member']['phone'],
                    isEmail: false,
                    email: email,
                    isShowChangeNumber: true,
                  ),
              arguments: {
                ArgChangeNumberOtp.email: response?.data['user']['email'],
                ArgChangeNumberOtp.userID: response?.data['user']['member']
                    ['userID'],
              });
        }
        Get.offAll(() => MainPage(), binding: HomeBindings());
        OneSignal.login(response.data['user']['id'].toString());
        update();
        accessToken.val = response.data['token'];
        restApiController.updateAccessToken(accessToken.val);
      } else {
        errorMessage.value =
            response.data['message'] ?? response?.data['email'][0];
        isError.value = true;
        isEmailNotValid.value = errorMessage.contains('email');
        update();
      }
      if (isCheck.isTrue) {
        emailPref.val = email;
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error login ${e.message}');
    }
  }

  void loginSocialMedia(
      {required String email,
      required String token,
      required RegisterType registerType}) async {
    if (email.isEmpty) return;
    try {
      isLoading.value = true;
      update();
      var parameter = {"email": email};

      String getEndpointLogin() {
        switch (registerType) {
          case RegisterType.google:
            return Endpoint.loginGoogle;
          case RegisterType.facebook:
            return Endpoint.loginFacebook;
          case RegisterType.apple:
            return Endpoint.loginApple;
          default:
            return '';
        }
      }

      var response = await restApiController.post(
          endpoint: getEndpointLogin(), data: parameter, token: token);

      isLoading.value = false;
      if (response?.statusCode == 200) {
        if (response.data['user']['member']['isVerified'] == false) {
          update();
          return Get.to(
              () => OtpPage(
                    otpValue: response.data['user']['member']['phone'],
                    isEmail: false,
                    email: email,
                    isShowChangeNumber: true,
                  ),
              arguments: {
                ArgChangeNumberOtp.email: response?.data['user']['email'],
                ArgChangeNumberOtp.userID: response?.data['user']['member']
                    ['userID'],
              });
        }
        Get.offAll(() => MainPage(), binding: HomeBindings());
        OneSignal.login(response.data['user']['id'].toString());
        update();
        accessToken.val = response.data['token'];
        restApiController.updateAccessToken(accessToken.val);
      } else if (response?.statusCode == 404) {
        handleRegister(registerType);
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Login Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      if (isCheck.isTrue) {
        emailPref.val = email;
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error login ${e.message}');
    }
  }

  void changeIsCheck() {
    isCheck.value = !isCheck.value;
    update();
  }

  void handleLoginSocialMedia({required RegisterType registerType}) async {
    try {
      switch (registerType) {
        case RegisterType.google:
          var googleUser = await _googleSignIn.signIn();
          String? email = googleUser?.email;
          var googleAuth = await googleUser?.authentication;
          var token = googleAuth?.accessToken;
          loginSocialMedia(
              email: email ?? '',
              token: token ?? '',
              registerType: registerType);
          update();
          break;
        case RegisterType.facebook:
          String? facebookEmail;
          final LoginResult result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
            final AccessToken accessToken = result.accessToken!;

            var userData = await FacebookAuth.instance.getUserData();

            userData.forEach((key, value) {
              if ("email" == key) facebookEmail = value;
            });
            loginSocialMedia(
                email: facebookEmail ?? '',
                token: accessToken.token,
                registerType: registerType);
          }
          update();
          break;
        case RegisterType.apple:
          var appleGivenName = Get.find<MyPref>().appleGivenName;
          var appleFamilyName = Get.find<MyPref>().appleFamilyName;
          var appleEmail = Get.find<MyPref>().appleEmail;
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          if (credential.givenName?.isNotEmpty ?? false) {
            appleGivenName.val = credential.givenName ?? '';
          }
          if (credential.familyName?.isNotEmpty ?? false) {
            appleFamilyName.val = credential.familyName ?? '';
          }
          if (credential.email?.isNotEmpty ?? false) {
            appleEmail.val = credential.email ?? '';
          }
          loginSocialMedia(
              email: credential.email ?? appleEmail.val,
              token: credential.identityToken ?? '',
              registerType: registerType);
          break;
        default:
          break;
      }
    } catch (error) {
      log(error.toString());
    }
  }

  void handleRegister(RegisterType registerType) {
    final registerController = Get.find<RegisterController>();
    switch (registerType) {
      case RegisterType.google:
        registerController.handleRegisterGoogle();
        break;
      case RegisterType.facebook:
        registerController.handleRegisterFacebook();
        break;
      case RegisterType.apple:
        registerController.handleRegisterApple();
        break;
      default:
        break;
    }
  }

  void updateIsError(bool value) {
    isError.value = value;
    update();
  }
}
