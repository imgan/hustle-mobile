import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/book_recovery_controller.dart';
import 'package:intl/intl.dart';

import '../../../class/widget/item_date.dart';

class DateBookRecoverySection extends StatelessWidget {
  const DateBookRecoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookRecoveryController>();
    return GetBuilder<BookRecoveryController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        height: 35,
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final DateFormat formatter = DateFormat.E();
              final date = controller.dates[index];
              return ItemDate(
                date: '${formatter.format(date)}, ${date.day}',
                isSelected: controller.currentDateIndex.value == index,
                onTap: () {
                  controller.updateDateIndex(index);
                  controller.updateMonth(DateFormat('MMMM yyyy').format(date));
                  controller.getSchedules();
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: controller.dates.length),
      );
    });
  }
}
