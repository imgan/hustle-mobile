import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../model/voucher.dart';
import '../../../../utils/colors.dart';

class VoucherHistoryItem extends StatelessWidget {
  const VoucherHistoryItem({
    super.key,
    required this.onTap,
    this.voucherHistory,
    this.width,
    this.isSelected,
    this.totalVoucher,
  });

  final VoidCallback onTap;
  final Voucher? voucherHistory;
  final double? width;
  final bool? isSelected;
  final int? totalVoucher;

  @override
  Widget build(BuildContext context) {
    String? expired =
        voucherHistory?.expired?.formatDate(format: "dd MMMM yyyy") ?? '';
    String? transactionDate =
        voucherHistory?.transactionDate?.formatDate(format: "dd-MM-yyyy");
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width ?? Get.width / 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: ShapeDecoration(
              color: (isSelected ?? false)
                  ? primaryColor.withOpacity(0.3)
                  : Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    ///API not finished, add proper name
                    voucherHistory!.name ?? '',
                    style: DDinExp.bold.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_alert.svg",
                        ),
                        const SizedBox(width: 5),
                        Text(
                          voucherHistory?.description ?? '',
                          textAlign: TextAlign.center,
                          style: DDinExp.regular.copyWith(
                            color: gray,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_valid_date.svg",
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Valid until: $expired',
                          textAlign: TextAlign.center,
                          style: DDinExp.regular.copyWith(
                            color: gray,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          transactionDate ?? '',
                          textAlign: TextAlign.center,
                          style: DDinExp.regular.copyWith(
                            color: gray,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 30,
            bottom: 30,
            child: Container(
                width: 20,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(color: Color(0xFFE6E6E6), width: 0),
                      left: BorderSide(color: Color(0xFFE6E6E6)),
                      top: BorderSide(color: Color(0xFFE6E6E6)),
                      bottom: BorderSide(color: Color(0xFFE6E6E6))),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      topLeft: Radius.circular(100)),
                )),
          ),
          Positioned(
            left: 0,
            top: 30,
            bottom: 30,
            child: Container(
                width: 20,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(color: Color(0xFFE6E6E6)),
                      left: BorderSide(color: Color(0xFFE6E6E6), width: 0),
                      top: BorderSide(color: Color(0xFFE6E6E6)),
                      bottom: BorderSide(color: Color(0xFFE6E6E6))),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100)),
                )),
          ),
          Visibility(
            visible: (totalVoucher ?? 0) > 1,
            child: Positioned(
              right: 30,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: ShapeDecoration(
                  color: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  'x$totalVoucher',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
