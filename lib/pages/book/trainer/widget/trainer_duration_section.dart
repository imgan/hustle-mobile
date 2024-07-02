import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/location_detail_section.dart';

import '../../../../model/trainer.dart';
import '../../../../profile/upcomingclass/widget/upcoming_point_reward.dart';
import '../../../../utils/widgets/my_credit.dart';

class TrainerDurationSection extends StatelessWidget {
  const TrainerDurationSection({super.key, required this.trainer});

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return Visibility(
      visible: !isFromBookingHistory,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 28,
            ),
            Row(
              children: [
                LocationDetailSection(
                    duration: trainer?.duration ?? 0,
                    location: trainer?.location?.locationName ?? ''),
                const Spacer(),
                MyCredit(
                  credit: trainer?.price.toString() ?? '0',
                  iconSize: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                DisabledPointReward(
                  reward: '+${trainer?.rewardPoint ?? 0}',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
