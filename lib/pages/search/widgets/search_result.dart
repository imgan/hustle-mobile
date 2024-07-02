import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/search/search_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import '../../../model/class.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/home_bindings.dart';
import '../../book/recovery/book/argument_book_recovery.dart';
import '../../book/recovery/book/book_recovery_page.dart';
import '../../book/trainer/book/book_pt_page.dart';
import '../../bookingclass/class_schedule/class_schedule_page.dart';
import 'item_search_activity.dart';
import 'item_search_recent.dart';

class SearchResult extends StatelessWidget {
  final TextEditingController textSearchController;

  const SearchResult({super.key, required this.textSearchController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchHomeController>(builder: (_) {
      final controller = Get.find<SearchHomeController>();
      if (controller.isLoading.isTrue) {
        return const ListLoading(
          height: 20,
          itemCount: 3,
          marginHorizontal: 0,
        );
      }

      if (controller.message.isNotEmpty) {
        return Center(
          child: Text(
            controller.message.value,
            textAlign: TextAlign.center,
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        );
      }

      if (controller.isSearch.isFalse) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var recent = controller.recentSearch.val[index];
              return ItemSearchRecent(
                recent: recent,
                onTap: () {
                  textSearchController.text = recent;
                  controller.onSearchChanged(recent);
                  controller
                      .updateShowCancel(textSearchController.text.isNotEmpty);
                  controller.updateSearch(textSearchController.text.isNotEmpty);
                },
              );
            },
            separatorBuilder: (_, index) {
              return const SizedBox(
                height: 4,
              );
            },
            itemCount: controller.recentSearch.val.length);
      }

      return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var search = controller.search[index];
            return ItemSearchActivity(
              search: search,
              onTap: () {
                switch (search.category) {
                  case 'class':
                    Get.to(() => ClassSchedulePage(),
                        arguments: SportClass(id: search.id, name: search.name),
                        binding: HomeBindings());
                    break;
                  case 'pt':
                    Get.to(
                        () => BookPTPage(
                              trainer: search.name,
                              price: search.price.toString(),
                            ),
                        arguments: [search.id]);
                    break;
                  case 'recovery':
                    Get.to(
                        () => BookRecoveryPage(
                              name: search.name,
                              title: 'Recovery',
                            ),
                        arguments: {
                          ArgumentBookRecovery.sportClassId: search.id,
                          ArgumentBookRecovery.locationId: '',
                          ArgumentBookRecovery.endpoint:
                              Endpoint.selectedTimeRecovery,
                          ArgumentBookRecovery.title: 'recovery',
                          ArgumentBookRecovery.price: search.price
                        });
                    break;
                  case 'wellness':
                    Get.to(
                        () => BookRecoveryPage(
                              name: search.name,
                              title: 'Wellness',
                            ),
                        arguments: {
                          ArgumentBookRecovery.sportClassId: search.id,
                          ArgumentBookRecovery.locationId: '',
                          ArgumentBookRecovery.endpoint:
                              Endpoint.selectedTimeWellness,
                          ArgumentBookRecovery.title: 'wellness',
                          ArgumentBookRecovery.price: search.price
                        });
                    break;
                }
              },
            );
          },
          separatorBuilder: (_, index) {
            return const SizedBox(
              height: 4,
            );
          },
          itemCount: controller.search.length);
    });
  }
}
