import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/search_filter.dart';

import '../../../../utils/colors.dart';
import 'item_pop_up.dart';

class ClassFilterSection extends StatelessWidget {
  const ClassFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    final searchController = TextEditingController();
    return GetBuilder<BookClassController>(builder: (_) {
      return Visibility(
        visible: controller.isPopUpLocations.isFalse,
        child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    Get.height < 800 ? Get.height / 2.3 : Get.height / 1.9,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: controller.isPopUpClass.isTrue ? 5 : 0),
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: disableColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SearchFilter(
                      controller: searchController,
                      onChanged: (value) {
                        controller
                            .updateShowCancel(searchController.text.isNotEmpty);
                        controller.onFilterClass(value);
                      },
                      isShowCancel: controller.isShowCancel.value,
                      onCancel: () {
                        searchController.clear();
                        controller.updateShowCancel(false);
                        controller.updateClasses();
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = controller.classes[index];

                              return ItemFilter(
                                location: item.name ?? '',
                                isCheck:
                                    controller.classSelected.contains(item.id),
                                onChanged: (value) {
                                  controller.updateClassSelected(
                                      item.id ?? 0, value ?? false);
                                },
                              );
                            },
                            itemCount: controller.classes.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 23,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            secondChild: Container(),
            crossFadeState: controller.isPopUpClass.isTrue
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
      );
    });
  }

}
