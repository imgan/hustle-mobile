import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/arg_change_number.dart';
import 'package:hustle_house_flutter/pages/otp/otp_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';

class ChangeNumberController extends GetxController {
  PhoneNumber number = PhoneNumber(isoCode: "ID");
  String dialCode = '+62';
  RxBool isDisableButton = true.obs;
  RxBool isLoading = false.obs;
  var arguments = Get.arguments;

  RestApiController restApiController = Get.find<RestApiController>();

  void changeNumber(String phone) async {
    try {
      isLoading.value = true;
      update();
      var parameter = {
        "email": arguments[ArgChangeNumberOtp.email],
        "userID": arguments[ArgChangeNumberOtp.userID],
        "phone": "$dialCode$phone",
        "phone_token": "Hustle1704"
      };
      var response = await restApiController.post(
          endpoint: Endpoint.changePhoneNumber, data: parameter);
      isLoading.value = false;

      if (response?.data['status_change_phone'] == true) {
        Get.to(() => OtpPage(
              otpValue: "$dialCode$phone",
              email: arguments[ArgChangeNumberOtp.email],
              isEmail: false,
              isShowChangeNumber: true,
            ));
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Change Number Failed',
          subTitle: response?.data['message'],
        ));
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error change number ${e.message}');
    }
  }

  void updateButton(bool value) {
    isDisableButton.value = value;
    update();
  }
}
