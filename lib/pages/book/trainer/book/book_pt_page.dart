import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/book_pt_controller.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/widgets/button_book_pt_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/widgets/date_book_pt_section.dart';
import 'package:hustle_house_flutter/utils/widgets/book/header_book_pt_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/widgets/schedule_time_pt_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_month.dart';

import '../../../../utils/colors.dart';

class BookPTPage extends StatelessWidget {
  BookPTPage({super.key, this.trainer, this.price});

  final String? trainer;
  final String? price;

  final BookPTController controller = Get.put(BookPTController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Book PT',
      ),
      body: GetBuilder<BookPTController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderBookSection(
              name: trainer,
              price: price,
            ),
            Divider(
              color: gray1,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 14),
              child: TextMonth(
                text: controller.month.value,
              ),
            ),
            const DateBookPTSection(),
            Container(
              margin: const EdgeInsets.only(left: 14),
              child: const TextMonth(
                text: 'Schedule Time',
              ),
            ),
            const ScheduleTimePTSection(),
            const Spacer(),
            const ButtonBookPTSection()
          ],
        );
      }),
    );
  }
}
