import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../pages/book/book_page.dart';
import '../../../pages/main/main_controller.dart';
import '../dialog/failed_dialog.dart';

void errorBook(String title, dynamic response) {
  String? rightButtonTitle = '';
  String? leftButtonTitle = '';
  VoidCallback onTap = () {};
  String? key = response['errors'].keys.first;
  String? value = response['errors'].values.first.join();
  String? errorMessage = value ?? response['message'];
  if (key == 'session') {
    rightButtonTitle = 'Schedule';
    leftButtonTitle = 'OK';
    onTap = () {
      Get.find<MainController>().updatePages(BookPage());
      Get.until((route) => Get.currentRoute == '/MainPage');
      Get.find<MainController>().updateIndex(1);
    };
  } else if (key == 'credit') {
    rightButtonTitle = 'Buy Credit';
    leftButtonTitle = 'Cancel';
    onTap = () {
      Get.until((route) => Get.currentRoute == '/MainPage');
      Get.find<MainController>().updateIndex(2);
    };
  }

  Get.dialog(FailedDialog(
      title: title,
      leftButtonTitle: leftButtonTitle,
      rightButtonTitle: rightButtonTitle,
      subTitle: errorMessage ?? '',
      onTap: onTap));
}
