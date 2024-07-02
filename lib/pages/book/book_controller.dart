import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  void disableTab() {
    if (tabController.index != 0) {
      tabController.index = 0;
    }
    update();
  }
}
