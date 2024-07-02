import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/purchase/widget/counter.dart';
import 'package:hustle_house_flutter/purchase/widget/first_time_section.dart';
import 'package:hustle_house_flutter/purchase/widget/price_guide_section.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/monthly/monthly_class_section.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';

class CreditTabPage extends StatelessWidget {
  CreditTabPage({super.key});

  final controller = Get.put(CreditController());

  @override
  Widget build(BuildContext context) {
    controller.getPackage();
    return GetBuilder<CreditController>(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstTimeSection(),
            SizedBox(
              height: 14.h,
            ),
            MonthlyClassSection(
              isLoading: controller.isLoading.isTrue,
              title: controller.title.value,
              description: controller.description.value,
              isPurchase: true,
            ),
            Divider(
              color: disableColor,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                controller.titleContent.value,
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: Center(
                child: Text(
                  controller.descriptionContent.value,
                  textAlign: TextAlign.center,
                  style: DDinExp.regular.copyWith(
                    color: gray,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ItemCounter(),
            PriceGuideSection(),
            _buttonOrderCredit()
          ],
        ),
      );
    });
  }

  Widget _buttonOrderCredit() {
    return Container(
        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
        child: PrimaryButton(
          isDisable: controller.currentValue.value <= 0,
          text: "Confirm",
          elevation: 0,
          isLoading: controller.isLoadingCredit.isTrue,
          onPressed: () {
            controller.orderCredit();
          },
        ));
  }
}
