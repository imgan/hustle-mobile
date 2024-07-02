import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/my_vouchers/widget/vouchers_item.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

class MyVouchersPage extends StatelessWidget {
  MyVouchersPage({Key? key}) : super(key: key);

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    var discountVoucher = controller.discountVoucher;
    var complimentaryVoucher = controller.complimentaryVoucher;
    bool isVoucherAvailable =
        discountVoucher.isNotEmpty || complimentaryVoucher.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'My Vouchers',
      ),
      body: Obx(
        () => Visibility(
          visible: isVoucherAvailable,
          replacement: Container(
            alignment: Alignment.center,
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
                    'You don’t have any vouchers.',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.discountVoucher.isNotEmpty,
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 1, top: 20),
                      child: Text("Discounts",
                          textAlign: TextAlign.center,
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ))),
                ),
                if (controller.discountVoucher.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      height: controller.complimentaryVoucher != []
                          ? Get.height - 200
                          : Get.height / 2.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              primary: false,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.discountVoucher.length,
                              itemBuilder: (context, index) {
                                final discountVouchers =
                                    controller.discountVoucher[index];
                                final voucherCount =
                                    discountVouchers.totalVoucher;
                                return MyVouchersItem(
                                  discountVoucher: discountVouchers,
                                  onTap: () {},
                                  isDiscount: true,
                                  totalVoucher: voucherCount,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 14,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Visibility(
                  visible: controller.complimentaryVoucher.isNotEmpty,
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      padding: const EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 4, top: 20),
                      child: Text("Complimentary Passes",
                          textAlign: TextAlign.center,
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ))),
                ),
                if (controller.complimentaryVoucher.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      height: controller.discountVoucher != []
                          ? Get.height - 200
                          : Get.height / 2.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              primary: false,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.complimentaryVoucher.length,
                              itemBuilder: (context, index) {
                                final complimentaryVouchers =
                                    controller.complimentaryVoucher[index];
                                final voucherCount =
                                    complimentaryVouchers.totalVoucher;
                                return MyVouchersItem(
                                  complimentaryVoucher: complimentaryVouchers,
                                  onTap: () {},
                                  isDiscount: false,
                                  totalVoucher: voucherCount,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 14,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
