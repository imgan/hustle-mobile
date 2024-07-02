import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/credits/active/credit_active_controller.dart';
import 'package:hustle_house_flutter/pages/credits/widgets/list_credit_section.dart';

import '../../../utils/widgets/empty/empty_class.dart';
import '../../../utils/widgets/loading/list_loading.dart';
import '../widgets/credit_expiring_section.dart';

class CreditActivePage extends StatelessWidget {
  CreditActivePage({super.key});

  final controller = Get.put(CreditActiveController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMoreActive.isTrue) {
        controller.getMoreCreditActive();
      }
    });
    return GetBuilder<CreditActiveController>(builder: (context) {
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: const ListLoading(
            height: 180,
          ),
        );
      }
      if (controller.creditsActive.isEmpty &&
          controller.creditsExpiring.isEmpty) {
        return const EmptyClass(
          image: 'assets/images/ic_no_credit_new.svg',
          text: 'You don\'t have any credits yet',
        );
      }
      if (controller.creditsActive.isEmpty &&
          controller.creditsExpiring.isNotEmpty) {
        return Column(
          children: [
            CreditExpiringSection(
              credits: controller.creditsExpiring,
            ),
            const Spacer(),
            const EmptyClass(
              image: 'assets/images/ic_no_credit_new.svg',
              text: 'You don\'t have any credits yet',
            ),
            const Spacer(),
          ],
        );
      }
      return ListView(
        controller: scrollController,
        children: [
          CreditExpiringSection(
            credits: controller.creditsExpiring,
          ),
          ListCreditSection(
            data: controller.creditsActive,
            onTap: (index) {
              controller.updateExpand(index);
            },
          )
        ],
      );
    });
  }
}
