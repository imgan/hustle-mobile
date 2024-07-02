import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import 'credit_price_guide.dart';
import 'expanded_text_widget.dart';

class PriceGuideSection extends StatelessWidget {
  PriceGuideSection({super.key});

  final controller = Get.find<CreditController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.h),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
      child: ExpandedTextWidget(
        text: "Credits Price Guide ",
        fontColor: Colors.black,
        fontSize: 14.sp,
        children: [_priceGuide()],
      ),
    );
  }

  Widget _priceGuide() {
    if (controller.isLoadingGuide.isTrue) {
      return ListLoading(
        height: 67.h,
        marginHorizontal: 0,
      );
    }
    return ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.priceGuide.length,
        itemBuilder: (context, index) {
          final priceGuide = controller.priceGuide[index];
          return CreditPriceGuide(
            priceGuide: priceGuide,
          );
        });
  }
}
