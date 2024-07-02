import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/ref_how_to_work.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/item_how_referral.dart';

import '../../../utils/typography/d_din_exp.dart';

class HowToReferralSection extends StatelessWidget {
  const HowToReferralSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RefHowToWork> refHowToWork = [
      RefHowToWork(
          image: 'assets/images/ic_ref_step_1.svg',
          description:
              'Invite your friends to register on the app and use your code during registration.'),
      RefHowToWork(
          image: 'assets/images/ic_ref_step_3.svg',
          description:
              'Get them to buy the First Timer Pack (with 50K off!) and you will automatically receive 5 credits for every successful referral!',
          isHideDivider: true),
    ];
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How does it work?',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: refHowToWork.length,
              itemBuilder: (context, index) {
                return ItemHowReferral(
                  refHowToWork: refHowToWork[index],
                );
              })
        ],
      ),
    );
  }
}
