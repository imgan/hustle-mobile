import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';
import '../otp/otp_page.dart';

class ForgotPasswordController extends GetxController {
  RxBool isValidEmail = false.obs;
  RxBool isLoading = false.obs;
  RxBool isHasEmail = true.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  void validateEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    isValidEmail.value = emailRegExp.hasMatch(email);
    update();
  }

  void checkEmail(String email) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email};
      var response = await restApiController.post(
          endpoint: Endpoint.checkEmail, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        isHasEmail.value = false;
        update();
      } else {
        isHasEmail.value = true;
        sendOtpToEmail(email);
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error check email ${e.message}');
    }
  }

  void sendOtpToEmail(String email) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email};
      var response = await restApiController.post(
          endpoint: Endpoint.forgotPasswordMobile, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        Get.dialog(AlertPopUpDialog(
          title: 'Reset Failed',
          subTitle: response?.data['message'],
        ));
        update();
      } else {
        Get.to(() => OtpPage(otpValue: email, isEmail: true));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error send otp to email ${e.message}');
    }
  }
}
