import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/referral_list.dart';
import 'item_list_referral.dart';

class ReferralUsedSection extends StatelessWidget {
  const ReferralUsedSection(
      {super.key,
      required this.referrers,
      required this.isShowMore,
      required this.onTap});

  final List<Referrer> referrers;
  final bool isShowMore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: referrers.isNotEmpty,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Referral Used by:',
              style: DDinExp.bold.copyWith(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 14,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isShowMore ? 3 : referrers.length,
              itemBuilder: (context, index) {
                final referred = referrers[index];
                return ItemListReferral(
                  referred: referred,
                );
              },
              separatorBuilder: (context, int index) {
                return const SizedBox(
                  height: 14,
                );
              },
            ),
            const SizedBox(
              height: 14,
            ),
            Visibility(
              visible: referrers.length > 3,
              child: InkWell(
                onTap: onTap,
                child: Center(
                  child: Text(
                    isShowMore ? 'Show more' : 'Show less',
                    textAlign: TextAlign.center,
                    style: DDinExp.regular.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
