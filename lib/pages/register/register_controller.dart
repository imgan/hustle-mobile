import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hustle_house_flutter/pages/register/register_step_2_page.dart';
import 'package:hustle_house_flutter/pages/register/register_type.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/api/rest_api_controller.dart';
import '../../utils/my_pref.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';
import '../otp/arg_change_number.dart';
import '../otp/otp_page.dart';
import '../termconditions/model/termcondition.dart';

class RegisterController extends GetxController {
  PhoneNumber number = PhoneNumber(isoCode: "ID");
  String dialCode = '+62';

  RxString? day;
  RxString month = ''.obs;
  RxString year = ''.obs;
  RxString dateOfBirth = ''.obs;
  RxBool isCheckTnC = false.obs;
  RxBool isCheckUpdate = false.obs;
  RxBool isAddHeight = false.obs;
  RxBool isValidateFirstReg = false.obs;
  RxBool isValidateSecondReg = false.obs;
  RxBool isErrorConfirmEmail = false.obs;
  RxBool isEmailNotValid = false.obs;
  RxBool isPasswordNotValid = false.obs;
  RxBool isErrorConfirmPassword = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingStep2 = false.obs;
  RxBool isLoadingTnC = false.obs;
  RxString token = ''.obs;
  RxList<TermConditionData> termConditionData = RxList();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'openid', 'profile'],
  );

  RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getTermCondition();
    super.onInit();
  }

  void changeAddHeight(bool value) {
    isAddHeight.value = value;
    update();
  }

  void changeIsCheckTnC({bool? value}) {
    isCheckTnC.value = value ?? !isCheckTnC.value;
    update();
  }

  void changeIsCheckUpdate({bool? value}) {
    isCheckUpdate.value = value ?? !isCheckUpdate.value;
    update();
  }

  bool isDisable() {
    return isCheckTnC.isFalse || isValidateSecondReg.isFalse;
  }

  void getPicked(DateTime? value) async {
    day = value?.day.toString().obs ?? ''.obs;
    month.value = value?.month.toString() ?? '';
    year.value = value?.year.toString() ?? '';
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateOfBirth.value = formatter.format(value ?? DateTime.now());
    update();
  }

  void changeStateFirstReg(bool value) {
    isValidateFirstReg.value = value;
    update();
  }

  void changeStateSecondReg(bool value) {
    isValidateSecondReg.value = value;
    update();
  }

  void changeErrorConfirmation(bool isErrorEmail, bool isErrorPassword) {
    isErrorConfirmEmail.value = isErrorEmail;
    isErrorConfirmPassword.value = isErrorPassword;
    update();
  }

  void getEmailPassword(String email, String password) {
    this.email.value = email;
    this.password.value = password;
    update();
  }

  void validateEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    isEmailNotValid.value = !emailRegExp.hasMatch(email);
    update();
  }

  void validatePassword(String password) {
    isPasswordNotValid.value = password.length < 8;
    update();
  }

  void register(
      {required String firstName,
      required String lastName,
      required String phone,
      required String referrer}) async {
    isLoadingStep2.value = true;
    update();
    try {
      var parameter = {
        "email": email.value,
        "password": password.value,
        "password_confirmation": password.value,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "dateOfBirth": dateOfBirth.value,
        "referrer": referrer,
        "isAgree": '1'
      };
      var response = await restApiController.post(
          endpoint: Endpoint.register, data: parameter);
      isLoadingStep2.value = false;
      if (response.data['status'] == true) {
        Get.to(
            () => OtpPage(
                  otpValue: phone,
                  isEmail: false,
                  email: email.value,
                  isShowChangeNumber: true,
                ),
            arguments: {
              ArgChangeNumberOtp.email: response?.data['data']?['email'] ??
                  response?.data['user']['email'],
              ArgChangeNumberOtp.userID:
                  response?.data['data']?['id'] ?? response?.data['user']['id'],
            });
      } else {
        String message = response.data['errors'].values.first.join() ??
            response.data['message'];
        Get.dialog(AlertPopUpDialog(
          title: message.toLowerCase().contains('referral')
              ? 'Invalid Referral Code'
              : 'Register Failed',
          subTitle: message,
        ));
      }
      update();
    } on DioException catch (e) {
      isLoadingStep2.value = false;
      update();
      log('error register ${e.message}');
    }
  }

  void handleRegisterGoogle() async {
    Map<String, String> accountSocialMedia;
    try {
      var googleUser = await _googleSignIn.signIn();
      String? email = googleUser?.email;
      var googleAuth = await googleUser?.authentication;
      var token = googleAuth?.accessToken;
      accountSocialMedia = {
        'firstName': googleUser?.displayName?.split(' ').first ?? '',
        'lastName': googleUser?.displayName?.split(' ').last ?? ''
      };
      checkEmail(email ?? '',
          accountSocialMedia: accountSocialMedia,
          registerType: RegisterType.google);
      this.email.value = email ?? '';
      this.token.value = token ?? '';
      update();
    } catch (error) {
      log(error.toString());
    }
  }

  void handleRegisterFacebook() async {
    String? facebookEmail;
    Map<String, String>? accountSocialMedia;
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        var userData = await FacebookAuth.instance.getUserData();

        userData.forEach((key, value) {
          if ("email" == key) facebookEmail = value;
          if ("name" == key) {
            accountSocialMedia = {
              'firstName': value.toString().split(' ').first,
              'lastName': value.toString().split(' ').last,
            };
          }
        });
        checkEmail(facebookEmail ?? '',
            accountSocialMedia: accountSocialMedia,
            registerType: RegisterType.facebook);
        email.value = facebookEmail ?? '';
        token.value = accessToken.token;
      } else {
        log(result.status.toString());
        log(result.message.toString());
      }
    } catch (error) {
      log(error.toString());
    }
  }

  void handleRegisterApple() async {
    var appleGivenName = Get.find<MyPref>().appleGivenName;
    var appleFamilyName = Get.find<MyPref>().appleFamilyName;
    var appleEmail = Get.find<MyPref>().appleEmail;
    Map<String, String> accountSocialMedia;
    try {
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
      accountSocialMedia = {
        'firstName': credential.givenName ?? appleGivenName.val,
        'lastName': credential.familyName ?? appleFamilyName.val
      };
      checkEmail(credential.email ?? appleEmail.val,
          accountSocialMedia: accountSocialMedia,
          registerType: RegisterType.apple);
      email.value = credential.email ?? appleEmail.val;
      token.value = credential.identityToken ?? '';
      update();
    } catch (error) {
      log(error.toString());
    }
  }

  void registerSocialMedia(
      {required String firstName,
      required String lastName,
      required String phone,
      required String referrer,
      required RegisterType registerType}) async {
    isLoadingStep2.value = true;
    update();
    try {
      var parameter = {
        "email": email.value,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "dateOfBirth": dateOfBirth.value,
        "referrer": referrer,
        "isAgree": '1'
      };

      String getEndpointRegister() {
        switch (registerType) {
          case RegisterType.google:
            return Endpoint.registerGoogle;
          case RegisterType.facebook:
            return Endpoint.registerFacebook;
          case RegisterType.apple:
            return Endpoint.registerApple;
          default:
            return '';
        }
      }

      var response = await restApiController.post(
          endpoint: getEndpointRegister(), data: parameter, token: token.value);
      isLoadingStep2.value = false;
      if (response.data['status'] == true) {
        Get.to(
            () => OtpPage(
                  otpValue: phone,
                  isEmail: false,
                  email: email.value,
                  isShowChangeNumber: true,
                ),
            arguments: {
              ArgChangeNumberOtp.email: response?.data['data']?['email'] ??
                  response?.data['user']['email'],
              ArgChangeNumberOtp.userID:
                  response?.data['data']?['id'] ?? response?.data['user']['id'],
            });
      } else {
        String message = response.data['errors'].values.first.join() ??
            response.data['message'];
        Get.dialog(AlertPopUpDialog(
          title: message.toLowerCase().contains('referral')
              ? 'Invalid Referral Code'
              : 'Register Failed',
          subTitle: message,
        ));
      }
      update();
    } on DioException catch (e) {
      isLoadingStep2.value = false;
      update();
      log('error register ${e.message}');
    }
  }

  void checkEmail(String email,
      {GoogleSignInAccount? googleSignInAccount,
      Map<String, String>? accountSocialMedia,
      RegisterType? registerType}) async {
    if (email.isEmpty) return;
    isLoading.value = true;
    try {
      var parameter = {"email": email};
      var response = await restApiController.post(
          endpoint: Endpoint.checkEmail, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        Get.to(() => RegisterStep2Page(
              accountSocialMedia: accountSocialMedia,
              registerType: registerType ?? RegisterType.normal,
            ));
        isCheckTnC.value = false;
        isValidateSecondReg.value = false;
      } else {
        Get.dialog(AlertPopUpDialog(
            title: 'Register Failed', subTitle: response.data['message']));
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error check email ${e.message}');
    }
  }

  void getTermCondition() async {
    try {
      isLoadingTnC.value = true;
      var response =
          await restApiController.get(endpoint: Endpoint.termCondition);
      if (response.data['status'] == true) {
        termConditionData.value = List<TermConditionData>.from(
            response.data["data"].map((x) => TermConditionData.fromJson(x)));
      }
      isLoadingTnC.value = false;
    } on DioException catch (e) {
      isLoadingTnC.value = false;
      update();
      log('error fetch term condition data ${e.message}');
    }
  }

  void updateEmailNotValid(bool value) {
    isEmailNotValid.value = value;
    update();
  }

  void updateIsErrorConfirmEmail(bool value) {
    isErrorConfirmEmail.value = value;
    update();
  }

  void updateIsPasswordNotValid(bool value) {
    isPasswordNotValid.value = value;
    update();
  }

  void updateIsErrorConfirmPassword(bool value) {
    isErrorConfirmPassword.value = value;
    update();
  }
}
