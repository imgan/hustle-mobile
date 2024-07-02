import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/voucherhistory/widget/voucher_history_item.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';
import '../../profile_controller.dart';

class VoucherHistoryTab extends StatelessWidget {
  VoucherHistoryTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMoreVoucher.isTrue) {
        controller.loadNextVoucher();
      }
    });

    return GetBuilder<ProfileController>(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
          padding: const EdgeInsets.all(0),
          child: Visibility(
            visible: controller.voucherHistory.isNotEmpty,
            replacement: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: Get.height / 3.5),
              width: Get.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/ic_no_voucher.svg",
                      height: 119,
                      width: 161.92,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'You haven’t made any purchase',
                      textAlign: TextAlign.center,
                      style: DDinExp.regular.copyWith(
                        color: gray2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: ListView.separated(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.voucherHistory.length,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        final voucherHistory =
                            controller.voucherHistory()[index];
                        return VoucherHistoryItem(
                          voucherHistory: voucherHistory,
                          onTap: () {},
                          totalVoucher: voucherHistory.totalVoucher,
                        );
                      },
                    ),
                  ),
                ),
                if (controller.isLoadingVoucherHistory.value == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
