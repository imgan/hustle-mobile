import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_page.dart';
import 'package:hustle_house_flutter/profile/profile_page.dart';
import 'package:hustle_house_flutter/purchase/purchase_page.dart';

import '../book/book_page.dart';

class MainController extends GetxController {
  RxInt index = 0.obs;
  RxList<Widget> pages =
      [const HomePage(), BookPage(), PurchasePage(), ProfilePage()].obs;

  void updateIndex(int value) {
    index.value = value;
    update();
  }

  void updatePages(Widget page) {
    pages[1] = page;
    update();
  }
}
