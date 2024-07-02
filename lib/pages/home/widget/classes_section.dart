import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_page.dart';
import 'package:hustle_house_flutter/pages/book/class/status_book.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/home/widget/label_menu.dart';
import 'package:hustle_house_flutter/pages/main/main_controller.dart';

import '../../../utils/widgets/loading/loading.dart';
import '../../book/class/detail/argument_class_detail.dart';
import '../../bookingclass/class/class_page.dart';
import 'item_class.dart';

class ClassesSection extends StatelessWidget {
  const ClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final mainController = Get.find<MainController>();
    return GetBuilder<HomeController>(builder: (_) {
      return switch (controller.classesState.value) {
        LoadingState() => Loading(
            height: 318.h,
          ),
        ErrorState(error: var err) => Text(err ?? ''),
        SuccessState<List<SportClass>>(result: var res) => Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LabelMenu(
                  menu: controller.titleContent.value,
                  description: controller.descriptionContent.value,
                  onTap: () {
                    mainController.updatePages(const ClassPage());
                    mainController.updateIndex(1);
                  },
                ),
                SizedBox(
                  height: 318.h,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final sportClass = res?[index];
                        return ItemClass(
                          sportClass: sportClass,
                          onTap: () {
                            Get.to(() => ClassDetailPage(), arguments: {
                              ArgumentClassDetail.statusBook: StatusBook.book,
                              ArgumentClassDetail.classDetail: sportClass
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: res?.length ?? 0),
                ),
              ],
            ),
          ),
        _ => const SizedBox()
      };
    });
  }
}
