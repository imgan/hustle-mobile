import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/trainer.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import '../../../../profile/upcomingclass/widget/upcoming_point_reward.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/widgets/my_credit.dart';
import '../detail/arg_trainer_detail.dart';

class DateTrainerSection extends StatelessWidget {
  const DateTrainerSection({super.key, required this.trainer});

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return Visibility(
      visible: isFromBookingHistory && !controller.isCancelled(),
      child: Column(
        children: [
          Divider(
            color: gray1,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.arguments[ArgTrainerDetail.date] ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    MyCredit(
                      credit: trainer?.price.toString() ?? '0',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DisabledPointReward(
                      reward: "+${trainer?.rewardPoint ?? 0}",
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
