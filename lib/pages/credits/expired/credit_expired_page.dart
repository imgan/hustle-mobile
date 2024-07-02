import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/credits/expired/credit_expired_controller.dart';

import '../../../utils/widgets/empty/empty_class.dart';
import '../widgets/list_credit_section.dart';

class CreditExpiredPage extends StatelessWidget {
  CreditExpiredPage({super.key});

  final controller = Get.put(CreditExpiredController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreCredit();
      }
    });
    return GetBuilder<CreditExpiredController>(builder: (_) {
      if (controller.credits.isEmpty) {
        return const EmptyClass(
          image: 'assets/images/ic_no_credit_new.svg',
          text: 'You don\'t have any credits yet',
        );
      }
      return ListView(
        controller: scrollController,
        children: [
          ListCreditSection(
            data: controller.credits,
            isExpired: true,
            onTap: (index) {
              controller.updateExpand(index);
            },
          ),
        ],
      );
    });
  }
}
