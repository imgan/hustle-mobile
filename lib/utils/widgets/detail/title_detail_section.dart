import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../profile/upcomingclass/widget/upcoming_point_reward.dart';
import '../my_credit.dart';

class TitleDetailSection extends StatelessWidget {
  const TitleDetailSection(
      {super.key,
      required this.title,
      required this.isShowCredit,
      required this.price,
      this.isShowPoint,
      required this.rewardPoint,
      this.isShowDisablePoint});

  final String title;
  final bool isShowCredit;
  final String price;
  final bool? isShowPoint;
  final int rewardPoint;
  final bool? isShowDisablePoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: DDinExp.extraBold.copyWith(
              color: Colors.black,
              fontSize: 22.sp,
            ),
          ),
        ),
        const Spacer(),
        Visibility(
            visible: isShowCredit,
            child: MyCredit(
              credit: price,
              colors: Colors.white,
            )),
        SizedBox(
          width: 10.w,
        ),
        Visibility(
          visible: isShowPoint ?? false,
          child: DisabledPointReward(
            reward: '+$rewardPoint',
          ),
        )
      ],
    );
  }
}
