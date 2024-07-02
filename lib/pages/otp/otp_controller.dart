import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/create_new_password.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/my_pref.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';
import 'otp_success_page.dart';

class OtpController extends GetxController {
  RxBool isDisableButton = true.obs;
  RxInt second = 59.obs;
  RxString labelOtp = 'Resending OTP in'.obs;
  RxBool isTimerStop = false.obs;
  Timer? timer;
  RxBool isLoading = false.obs;
  RxString code = ''.obs;
  int count = 1;
  var arguments = Get.arguments;

  var accessToken = Get.find<MyPref>().accessToken;

  RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void changeStateButtonDisable(bool value) {
    isDisableButton.value = value;
    update();
  }

  void startTimer() {
    isTimerStop.value = false;
    labelOtp.value = 'Resending OTP in';
    second.value = count > 3 ? (60 * 15) : 59;
    count++;
    update();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (second.value == 0) {
          isTimerStop.value = true;
          labelOtp.value = 'Don’t receive the OTP?';
          timer.cancel();
          update();
        } else {
          second.value--;
          update();
        }
      },
    );
  }

  void updateCode(String value) {
    code.value = value;
    update();
  }

  void verifyOtp({required String email}) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email, "code": code.value};
      var response = await restApiController.post(
          endpoint: Endpoint.verifyOtp, data: parameter);
      isLoading.value = false;
      if (response.statusCode == 200) {
        accessToken.val = response.data['token'];
        restApiController.updateAccessToken(accessToken.val);
        OneSignal.login(response.data['user']['id'].toString());
        Get.to(() => OtpSuccessPage(isNewPassword: false));
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Verify Failed',
          subTitle: response?.data['message'],
        ));
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error verify ${e.message}');
    }
  }

  void verifyOtpEmail({required String email}) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email, "code": code.value};
      var response = await restApiController.post(
          endpoint: Endpoint.verifyOtp, data: parameter);
      isLoading.value = false;
      if (response.statusCode == 200) {
        Get.to(() => CreateNewPasswordPage(
              email: email,
              code: code.value,
            ));
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Verify Failed',
          subTitle: response?.data['message'],
        ));
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error verify ${e.message}');
    }
  }

  void resendOtp({required String email}) async {
    try {
      var parameter = {"email": email};
      await restApiController.post(
          endpoint: Endpoint.resendOtp, data: parameter);
      isLoading.value = false;
      startTimer();
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error verify ${e.message}');
    }
  }

  void resendOtpEmail({required String email}) async {
    try {
      var parameter = {"email": email};
      await restApiController.post(
          endpoint: Endpoint.forgotPasswordMobile, data: parameter);
      isLoading.value = false;
      startTimer();
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error verify ${e.message}');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
