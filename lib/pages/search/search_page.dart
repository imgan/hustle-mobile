import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/search/search_controller.dart';
import 'package:hustle_house_flutter/pages/search/widgets/search_bar_home.dart';
import 'package:hustle_house_flutter/pages/search/widgets/search_information.dart';
import 'package:hustle_house_flutter/pages/search/widgets/search_result.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final controller = Get.put(SearchHomeController());
  final textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SearchHomeController>(builder: (_) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarHome(
                  onChanged: (value) {
                    controller.onSearchChanged(value);
                    controller
                        .updateShowCancel(textSearchController.text.isNotEmpty);
                    controller
                        .updateSearch(textSearchController.text.isNotEmpty);
                  },
                  controller: textSearchController,
                  isShowCancel: controller.isShowCancel.isTrue,
                  onCancel: () {
                    textSearchController.clear();
                    controller
                        .updateShowCancel(textSearchController.text.isNotEmpty);
                    controller
                        .updateSearch(textSearchController.text.isNotEmpty);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SearchInformation(),
                const SizedBox(
                  height: 16,
                ),
                SearchResult(textSearchController: textSearchController)
              ],
            ),
          );
        }),
      ),
    );
  }
}
