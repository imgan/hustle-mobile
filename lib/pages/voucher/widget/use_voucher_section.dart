import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/voucher/widget/user_voucher_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/widgets/loading/list_loading.dart';
import '../../home/widget/item_voucher.dart';

class UseVoucherSection extends StatelessWidget {
  const UseVoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UseVoucherController>();
    return GetBuilder<UseVoucherController>(builder: (_) {
      if (controller.isLoading.isTrue) {
        return const ListLoading(
          marginHorizontal: 0,
        );
      }

      if (controller.message.value.isNotEmpty) {
        return Text(
          controller.message.value,
          textAlign: TextAlign.center,
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        );
      }
      return ListView.separated(
        itemCount: controller.vouchers.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final voucher = controller.vouchers[index];
          return ItemVoucher(
            width: Get.width,
            totalVoucher: voucher.totalVoucher,
            isSelected: controller.selectedVoucher.value == voucher.code,
            isHide:
                !controller.isHidePromoCode(voucher.packages, voucher.credits),
            isDisable: controller.isDisable(
              category: voucher.category ?? '',
              locationID: voucher.rewardVoucher?.locationID,
            ),
            voucher: voucher,
            onTap: () {
              controller.updateSelectedVoucher(voucher.code ?? '');
            },
          );
        },
        separatorBuilder: (context, index) {
          final voucher = controller.vouchers[index];
          if (controller.isHidePromoCode(voucher.packages, voucher.credits)) {
            return const SizedBox();
          }
          return const SizedBox(
            height: 14,
          );
        },
      );
    });
  }
}
