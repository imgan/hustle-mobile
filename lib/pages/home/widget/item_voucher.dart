import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/voucher.dart';
import '../../../utils/colors.dart';
import '../../../utils/extension/string.dart';

class ItemVoucher extends StatelessWidget {
  const ItemVoucher(
      {super.key,
      this.width,
      this.isSelected,
      this.totalVoucher,
      this.onTap,
      this.voucher,
      this.isDisable,
      this.isHide});

  final double? width;
  final bool? isSelected;
  final int? totalVoucher;
  final VoidCallback? onTap;
  final Voucher? voucher;
  final bool? isDisable;
  final bool? isHide;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isHide ?? true,
      child: InkWell(
        onTap: isDisable ?? false ? null : onTap,
        child: Stack(
          children: [
            Container(
              width: width ?? Get.width / 1.4,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              decoration: ShapeDecoration(
                color: bgColor(),
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
                      voucher?.rewardVoucher?.name ?? voucher?.name ?? '',
                      style: DDinExp.bold.copyWith(
                        color: isDisable ?? false ? gray2 : Colors.black,
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
                      Visibility(
                        visible:
                            (voucher?.rewardVoucher?.description?.isNotEmpty ??
                                    false) ||
                                (voucher?.description?.isNotEmpty ?? false),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/ic_alert.svg",
                            ),
                            const SizedBox(width: 5),
                            Text(
                              voucher?.rewardVoucher?.description ??
                                  voucher?.description ??
                                  '',
                              textAlign: TextAlign.center,
                              style: DDinExp.regular.copyWith(
                                color: isDisable ?? false ? gray2 : gray,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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
                            voucher?.expired != null
                                ? 'Valid until: ${voucher?.expired?.formatDate()}'
                                : 'No expired date',
                            textAlign: TextAlign.center,
                            style: DDinExp.regular.copyWith(
                              color: isDisable ?? false ? gray2 : gray,
                              fontSize: 12,
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
      ),
    );
  }

  Color bgColor() {
    if (isDisable ?? false) {
      return disableColor.withOpacity(0.5);
    }
    if (isSelected ?? false) {
      return primaryColor.withOpacity(0.3);
    } else {
      return Colors.white;
    }
  }
}
