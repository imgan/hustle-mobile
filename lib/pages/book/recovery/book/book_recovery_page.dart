import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/book_recovery_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/widgets/button_book_recovery_section.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/widgets/date_book_recovery_section.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/widgets/schedule_time_recovery_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/book/header_book_pt_section.dart';
import '../../../../utils/widgets/text/text_month.dart';

class BookRecoveryPage extends StatelessWidget {
  BookRecoveryPage({super.key, this.name, this.title});

  final String? title;
  final String? name;

  final BookRecoveryController controller = Get.put(BookRecoveryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Book $title',
      ),
      body: GetBuilder<BookRecoveryController>(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderBookSection(
                      name: name,
                      price: controller.total.value.toString(),
                    ),
                    Divider(
                      color: gray1,
                      thickness: 1,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 14, right: 14),
                          child: TextMonth(
                            text: controller.month.value,
                          ),
                        ),
                        const DateBookRecoverySection(),
                      ],
                    ),
                    Divider(
                      color: gray1,
                      thickness: 1,
                    ),
                    const ScheduleTimeRecoverySection(),
                  ],
                ),
              ),
            ),
            const ButtonBookRecoverySection()
          ],
        );
      }),
    );
  }
}
