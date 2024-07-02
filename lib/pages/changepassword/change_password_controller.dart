import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/custom_dialog.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController =
      TextEditingController();
  static const int minimumPasswordCharacter = 7;

  //RxBool isValidEmail = false.obs;
  RxBool isValidOldPasswordsLenght = true.obs;
  RxBool isValidPasswords = false.obs;

  RxBool isLoading = false.obs;
  RxBool isPasswordTrue = false.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  void checkValidOldPasswordsLenght() {
    final oldPass = oldPasswordController.text;
    isValidOldPasswordsLenght.value = oldPass.length > minimumPasswordCharacter;
    update();
  }

  void checkPasswordsValid() {
    final oldPass = newPasswordController.text;
    final newPass = newPasswordController.text;
    final newPassConfirm = newPasswordConfirmController.text;
    if (newPass == newPassConfirm &&
        oldPass.length > minimumPasswordCharacter &&
        newPass.length > minimumPasswordCharacter &&
        newPassConfirm.length > minimumPasswordCharacter) {
      isValidPasswords.value = true;
    } else {
      isValidPasswords.value = false;
    }
    update();
  }

// RxBool isPasswordsValid() {
//   final oldPass = newPasswordController.text;
//   final newPass = newPasswordController.text;
//   final newPassConfirm = newPasswordConfirmController.text;
//   if (newPass == newPassConfirm &&
//       oldPass.length > minimumPasswordCharacter &&
//       newPass.length > minimumPasswordCharacter &&
//       newPassConfirm.length > minimumPasswordCharacter) {
//     return RxBool(true);
//   } else {
//     return RxBool(false);
//   }
// }
// void validateEmail(String email) {
//   // fungsi validasi email
//   final RegExp emailRegExp =
//       RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//   isValidEmail.value = emailRegExp.hasMatch(email);
//   update();
// }

  void createNewPassword() async {
    //Get.dialog(CustomDialog().error(email));
    //send to server
    try {
      isLoading.value = true;
      update();
      var parameter = {
        "old_password": oldPasswordController.text,
        "password": newPasswordController.text,
        "password_confirmation": newPasswordConfirmController.text
      };
      var response = await restApiController.post(
          endpoint: Endpoint.changePassword, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        //Get.to(() => RegisterStep2Page());
        //Get.dialog(CustomDialog().error('Fail to Change Password'));
        //isHasEmail.value = false;
        isPasswordTrue.value = true;
        update();
      } else {
        //goto ganti pass
        //Get.to(() => OtpSuccessPage(
        // title: 'Password Changed',
        // subtitle: 'Your password has been changed successfully.',
        //isNewPassword: true));
        //Get.dialog(CustomDialog().error('Succsess'));
        isPasswordTrue.value = false;
        Get.dialog(CustomDialog().success('Password Changed', () {
          Get.back();
          Get.back();
        }));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error create new password ${e.message}');
    }
  }
}