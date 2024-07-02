import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/credits/active/credit_active_controller.dart';
import 'package:hustle_house_flutter/pages/credits/widgets/item_credit_expiring.dart';

import '../../../utils/typography/d_din_exp.dart';
import '../../../utils/widgets/empty/empty_class.dart';

class PopUpCreditExpiring extends StatelessWidget {
  PopUpCreditExpiring({super.key});

  final scrollController = ScrollController();
  final controller = Get.find<CreditActiveController>();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMoreExpiring.isTrue) {
        controller.getMoreCreditExpiring();
      }
    });
    return GetBuilder<CreditActiveController>(builder: (_) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 15),
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expiring soon',
              textAlign: TextAlign.center,
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close_rounded,
                size: 28,
                color: Colors.black,
              ),
            )
          ],
        ),
        content: Container(
          margin: const EdgeInsets.only(bottom: 14),
          child: SizedBox(
            width: double.maxFinite,
            child: _content(),
          ),
        ),
      );
    });
  }

  Widget _content() {
    if (controller.creditsExpiring.isEmpty) {
      return const EmptyClass(
        image: 'assets/images/ic_no_credit_new.svg',
        text: 'You don\'t have any credits yet',
      );
    }
    return ListView.separated(
        shrinkWrap: true,
        controller: scrollController,
        itemBuilder: (context, index) {
          final credit = controller.creditsExpiring[index];
          return ItemCreditExpiring(
            credit: credit,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 14,
          );
        },
        itemCount: controller.creditsExpiring.length);
  }
}
