import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/search/search_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';

class SearchInformation extends StatelessWidget {
  const SearchInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchHomeController>();
    return GetBuilder<SearchHomeController>(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: controller.message.isEmpty &&
                (controller.recentSearch.val.isNotEmpty ||
                    controller.isSearch.isTrue),
            child: Text(
              controller.isSearch.isTrue ? 'Activities' : 'Recent',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Visibility(
            visible: controller.isSearch.isFalse &&
                controller.recentSearch.val.isNotEmpty,
            child: InkWell(
              onTap: () {
                controller.clearRecentSearch();
              },
              child: Text(
                'Clear',
                style: DDinExp.regular.copyWith(
                  color: gray,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
