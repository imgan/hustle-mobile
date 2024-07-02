import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/otp_success_page.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';

class NewPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController =
      TextEditingController();

  RxBool passwordsMatch = false.obs;
  RxBool isLoading = false.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  void checkPasswords() {
    final newPass = newPasswordController.text;
    final newPassConfirm = newPasswordConfirmController.text;
    if (newPass == newPassConfirm && newPass.length > 7) {
      passwordsMatch.value = true;
    } else {
      passwordsMatch.value = false;
    }
    update();
  }

  void createNewPassword(
      String email,
      TextEditingController newPasswordController,
      TextEditingController newPasswordConfirmController,
      String code) async {
    isLoading.value = true;
    update();
    try {
      var parameter = {
        "email": email,
        "password": newPasswordController.text,
        "password_confirmation": newPasswordConfirmController.text,
        "code": code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.resetPasswordMobile, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        Get.dialog(const AlertPopUpDialog(
          title: 'Change Password Failed',
          subTitle: 'Fail to Change Password',
        ));
        update();
      } else {
        Get.to(() => OtpSuccessPage(isNewPassword: true));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error create new password ${e.message}');
    }
  }
}
