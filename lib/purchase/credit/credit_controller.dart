import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/price_guide.dart';
import 'package:hustle_house_flutter/pages/checkout/checkout_first_package_page.dart';

import '../../model/package_first_timer.dart';
import '../../pages/checkout/checkout_credit_page.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/extension/string.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';

class CreditController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingGuide = true.obs;
  RxBool isLoadingCredit = false.obs;
  RxBool isLoadingFirstTime = false.obs;
  RxInt creditSelected = 100.obs;
  RxList<Package> packageFirstTimer = RxList();
  RxList<String> descriptions = RxList();
  RxList<PriceGuide> priceGuide = RxList();
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxString titleContent = ''.obs;
  RxString descriptionContent = ''.obs;

  final List<String> quickAmounts = [
    '10',
    '50',
    '100',
    '200',
    '300',
    '400',
  ];

  final RestApiController restApiController = Get.find<RestApiController>();
  final TextEditingController counterController = TextEditingController();

  RxInt currentValue = 0.obs;

  @override
  void dispose() {
    counterController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    getPackage();
    getCreditGuide();
    getSubContentCredit();
    counterController.text = "";
    currentValue.value = 0;
    super.onInit();
  }

  Future<void> orderFirstTime(String id) async {
    isLoadingFirstTime.value = true;
    update();
    try {
      var parameter = {"packageID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.orderPackage, data: parameter);
      if (response?.data['status'] == true) {
        Get.to(() => CheckoutFirstPackagePage());
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Order Failed',
          subTitle: response?.data['message'],
        ));
      }
      isLoadingFirstTime.value = false;
      update();
    } on DioException catch (e) {
      isLoadingFirstTime.value = false;
      update();
      log('error order ${e.message}');
    }
  }

  void getPackage() async {
    isLoading.value = true;
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.package);
      packageFirstTimer.value = response.data["data"]["firstTimer"] == null
          ? []
          : List<Package>.from(response.data["data"]["firstTimer"]
              .map((x) => Package.fromJson(x)));
      isLoading.value = false;
      if (packageFirstTimer.isNotEmpty) {
        descriptions.value =
            packageFirstTimer[0].description?.removeAllHtmlTags().split(',') ??
                [];
        descriptions
            .removeWhere((element) => element.isEmpty || element == ' ');
      }
      title.value = response?.data['data']['month_class_package']['title'];
      description.value =
          response?.data['data']['month_class_package']['description'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error package ${e.message}');
    }
  }

  void getCreditGuide() async {
    isLoadingGuide.value = true;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.creditPriceGuide);
      priceGuide.value = List<PriceGuide>.from(
          response.data["data"].map((x) => PriceGuide.fromJson(x)));
      isLoadingGuide.value = false;
      update();
    } on DioException catch (e) {
      isLoadingGuide.value = false;
      update();
      log('error price guide ${e.message}');
    }
  }

  void orderCredit() async {
    isLoadingCredit.value = true;
    update();
    try {
      final parameter = {"credit": currentValue.value.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.orderCredit, data: parameter);
      if (response?.data['status'] == true) {
        Get.to(() => CheckoutCreditPage());
      } else {
        final message = response?.data['errors'][0];
        Get.dialog(AlertPopUpDialog(title: 'Oops!', subTitle: message));
      }
      isLoadingCredit.value = false;
      update();
    } on DioException catch (e) {
      isLoadingCredit.value = false;
      update();
      log('error order credit ${e.message}');
    }
  }

  void getSubContentCredit() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.subContentCredit);
      titleContent.value = response?.data['data']['title'];
      descriptionContent.value = response?.data['data']['description'];
      update();
    } on DioException catch (e) {
      update();
      log('error subcontent class ${e.message}');
    }
  }

  void increment() {
    currentValue++;
    counterController.text = currentValue.toString();
    update();
  }

  void decrement() {
    currentValue > 0 ? currentValue-- : () {};
    counterController.text = (currentValue > 0 ? currentValue : "").toString();
    update();
  }

  void updateCreditSelected(int index) {
    creditSelected.value = index;
    update();
  }

  void updateCurrentValue(int value) {
    currentValue.value = value;
    update();
  }

  void updateCounterController(String text) {
    counterController.text = text;
    update();
  }
}
