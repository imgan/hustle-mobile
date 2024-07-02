import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/price_guide.dart';
import 'package:hustle_house_flutter/utils/extension/int.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../utils/colors.dart';

class CreditPriceGuide extends StatelessWidget {
  const CreditPriceGuide({super.key, this.priceGuide});

  final PriceGuide? priceGuide;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border(
              left: BorderSide(color: disableColor),
              top: BorderSide(width: 1, color: disableColor),
              right: BorderSide(color: disableColor),
              bottom: BorderSide(width: 1, color: disableColor),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.all(10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  priceGuide?.title ?? '',
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  '${priceGuide?.price?.formatIDR()}/credit',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                  children: [
                    WidgetSpan(
                      child: SvgPicture.asset(
                        "assets/images/ic_clock_outline.svg",
                        width: 14.w,
                        height: 14.h,
                      ),
                    ),
                    TextSpan(
                      text: " Expired in: ${priceGuide?.expiry ?? '0'} Days",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
