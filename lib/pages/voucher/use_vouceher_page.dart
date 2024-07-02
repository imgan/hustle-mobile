import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/voucher/widget/search_discount.dart';
import 'package:hustle_house_flutter/pages/voucher/widget/search_voucher.dart';
import 'package:hustle_house_flutter/pages/voucher/widget/use_voucher_section.dart';
import 'package:hustle_house_flutter/pages/voucher/widget/user_voucher_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/floating_button_text.dart';

class UseVoucherPage extends StatelessWidget {
  UseVoucherPage({super.key, this.title});

  final String? title;

  final controller = Get.put(UseVoucherController());
  final textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: title ?? 'Voucher',
      ),
      body: GetBuilder<UseVoucherController>(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                    children: [
                      _search(),
                      const SizedBox(
                        height: 14,
                      ),
                      const UseVoucherSection()
                    ],
                  ),
                ),
              ),
            ),
            FloatingButtonText(
              textButton: 'OK',
              onPressed: () async {
                controller.useDiscount();
                Get.back();
              },
              text: controller.selectedVoucher.value.isNotEmpty
                  ? '1 ${title ?? 'Voucher'} Applied'
                  : 'No ${title ?? 'Voucher'} Applied',
            )
          ],
        );
      }),
    );
  }

  Widget _search() {
    if (controller.type == 1) {
      return SearchDiscount(
        controller: textSearchController,
        onChanged: (value) {
          controller.updateDisableButton(value);
        },
        onCancel: () {
          textSearchController.clear();
          controller.type != 1 ? controller.getAvailableVoucher() : null;
          controller.clearSelectedVoucher();
        },
        onTap: () {
          controller.onSearchChanged(textSearchController.text);
        },
        isDisable: controller.isDisableButton.value,
      );
    }
    return SearchVoucher(
      controller: textSearchController,
      title: title,
      onCancel: () {
        textSearchController.clear();
        controller.type != 1 ? controller.getAvailableVoucher() : null;
        controller.clearSelectedVoucher();
      },
      onChanged: (value) {
        controller.onSearchChanged(value);
      },
    );
  }
}
