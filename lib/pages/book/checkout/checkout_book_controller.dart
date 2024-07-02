import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/book_recovery_controller.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/book_pt_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class_schedule/class_schedule_controller.dart';

import '../../../model/checkout_book.dart';

class CheckoutBookController extends GetxController {
  Rxn<CheckOutBook> checkOutBook = Rxn();

  @override
  void onInit() {
    initCheckOutBook();
    checkOutBook.value = getCheckOutBook();
    super.onInit();
  }

  CheckOutBook? getCheckOutBook() {
    switch (Get.currentRoute) {
      case '/ClassDetailPage':
        return Get.find<ClassDetailController>().checkOutBook.value;
      case '/BookPTPage':
        return Get.find<BookPTController>().checkOutBook.value;
      case '/BookRecoveryPage':
        return Get.find<BookRecoveryController>().checkOutBook.value;
      case '/ClassSchedulePage':
        return Get.find<ClassScheduleController>().checkOutBook.value;
    }
    update();
    return null;
  }

  void initCheckOutBook() {
    switch (Get.currentRoute) {
      case '/ClassDetailPage':
        Get.find<ClassDetailController>().initCheckOutBook();
        break;
      case '/BookPTPage':
        Get.find<BookPTController>().initCheckOutBook();
        break;
      case '/BookRecoveryPage':
        Get.find<BookRecoveryController>().initCheckOutBook();
        break;
      case '/ClassSchedulePage':
        Get.find<ClassScheduleController>().initCheckOutBook();
    }
  }

  void updateCheckoutBook() {
    if (Get.isRegistered<ClassDetailController>()) {
      checkOutBook.value =
          Get.find<ClassDetailController>().checkOutBook.value ??
              Get.find<ClassScheduleController>().checkOutBook.value;
    } else if (Get.isRegistered<BookPTController>()) {
      checkOutBook.value = Get.find<BookPTController>().checkOutBook.value;
    } else if (Get.isRegistered<BookRecoveryController>()) {
      checkOutBook.value =
          Get.find<BookRecoveryController>().checkOutBook.value;
    }
    update();
  }
}
