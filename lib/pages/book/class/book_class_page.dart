import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/filter_book_section.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/item_date.dart';
import 'package:hustle_house_flutter/utils/widgets/monthly/monthly_class_section.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class_schedule/class_schedule_section.dart';
import 'package:intl/intl.dart';

import '../../../utils/widgets/text/text_month.dart';

class BookClassPage extends StatelessWidget {
  BookClassPage({super.key});

  final BookClassController controller = Get.find<BookClassController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookClassController>(builder: (_) {
      return RefreshIndicator(
        onRefresh: () {
          return controller.refreshClass();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilterBookSection(),
              MonthlyClassSection(
                isLoading: controller.isLoadingMonthPackage.isTrue,
                title: controller.title.value,
                description: controller.description.value,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: TextMonth(
                  text: controller.month.value,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              _itemDate(),
              SizedBox(
                height: 20.h,
              ),
              ClassScheduleSection(
                isLoading: controller.isLoading.isTrue,
                isEmpty: controller.schedules.isEmpty,
                schedules: controller.schedules,
                isLoadingCredit: controller.isLoadingCredit.isTrue,
                height: Get.height / 2.5,
                onTapNotify: (id, index) {
                  controller.notifySchedule(id, index);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _itemDate() {
    return SizedBox(
      height: 35.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final DateFormat formatter = DateFormat.E();
            final date = controller.dates[index];
            return ItemDate(
              date: '${formatter.format(date)}, ${date.day}',
              isSelected: controller.currentIndex.value == index,
              onTap: () {
                controller.updateIndex(index);
                controller.updateMonth(DateFormat('MMMM yyyy').format(date));
                controller.getSchedules();
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.h,
            );
          },
          itemCount: controller.dates.length),
    );
  }
}