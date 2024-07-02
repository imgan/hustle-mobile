import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/purchaselist/purchase_waiting/purchase_waiting_controller.dart';
import 'package:hustle_house_flutter/pages/purchaselist/widgets/item_purchase_waiting.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';

import '../../../utils/widgets/dialog/cancel_dialog.dart';
import '../../../utils/widgets/loading/list_loading.dart';

class PurchaseWaitingPage extends StatelessWidget {
  PurchaseWaitingPage({super.key});

  final controller = Get.put(PurchaseWaitingController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.80 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMorePurchaseList();
      }
    });
    return GetBuilder<PurchaseWaitingController>(builder: (_) {
      final purchaseList = controller.purchaseList;
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: const ListLoading(
            itemCount: 10,
          ),
        );
      }

      if (purchaseList.isEmpty) {
        return const EmptyClass(
          image: 'assets/images/ic_no_completed_class.svg',
          text: 'You haven\'t made any purchases.',
        );
      }
      return Container(
        margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 8),
        child: ListView.separated(
          shrinkWrap: true,
          controller: scrollController,
          itemBuilder: (context, index) {
            final purchase = purchaseList[index];
            return InkWell(
              onTap: () {
                controller.paymentMidtrans(purchase.url ?? '');
              },
              child: ItemPurchaseWaiting(
                purchaseList: purchase,
                onTap: () {
                  Get.dialog(CancelDialog(
                      title: 'Cancel Order',
                      subTitle: 'Are you sure want to cancel this order?',
                      message: '',
                      onTap: () {
                        controller.cancelMidtrans(purchase.transactionId ?? '');
                      }));
                },
              ),
            );
          },
          itemCount: purchaseList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 14,
            );
          },
        ),
      );
    });
  }
}
