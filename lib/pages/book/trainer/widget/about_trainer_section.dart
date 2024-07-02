import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import '../../../../model/trainer.dart';
import '../../../../utils/typography/d_din_exp.dart';

class AboutTrainerSection extends StatelessWidget {
  final Trainer? trainer;

  const AboutTrainerSection({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('About',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 16,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(trainer?.about ?? 'No Information Available',
              maxLines: controller.isReadMore.isTrue ? null : 6,
              overflow:
                  controller.isReadMore.isTrue ? null : TextOverflow.ellipsis,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              )),
          Visibility(
            visible: (trainer?.about?.length ?? 0) > 300,
            child: const SizedBox(
              height: 14,
            ),
          ),
          Visibility(
            visible: (trainer?.about?.length ?? 0) > 300,
            child: InkWell(
              onTap: () {
                controller.updateReadMore();
              },
              child:
                  Text(controller.isReadMore.isTrue ? 'Read less' : 'Read more',
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      )),
            ),
          )
        ],
      ),
    );
  }
}
