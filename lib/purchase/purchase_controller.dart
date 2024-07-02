import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void disableVoucher() {
    if (tabController.index == 1) {
      tabController.index = 0;
    }
    update();
  }
}
