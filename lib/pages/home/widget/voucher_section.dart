import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../profile/my_vouchers/my_vouchers_page.dart';
import 'item_voucher.dart';
import 'label_menu.dart';

class VoucherSection extends StatelessWidget {
  const VoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (context) {
      return Visibility(
        visible: controller.vouchers.isNotEmpty,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelMenu(
              menu: 'Vouchers',
              onTap: () {
                Get.to(() => MyVouchersPage());
              },
            ),
            Container(
              height: 95,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final voucher = controller.vouchers[index];
                    return ItemVoucher(
                      totalVoucher: voucher.totalVoucher,
                      voucher: voucher,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: controller.vouchers.length),
            )
          ],
        ),
      );
    });
  }
}
