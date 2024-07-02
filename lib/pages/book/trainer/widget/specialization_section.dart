import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/trainer.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import 'item_specialization.dart';

class SpecializationSection extends StatelessWidget {
  SpecializationSection({super.key, required this.trainer});

  final controller = Get.find<TrainerDetailController>();

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 14, top: 20),
          child: Text(
            'Specialization',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _specialization(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _specialization() {
    if (trainer?.teacherSpecialization?.isEmpty ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text('No Specialization',
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            )),
      );
    }
    return SizedBox(
        height: 31,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = trainer
                ?.teacherSpecialization?[index].teacherSpecializationName?.name;
            return ItemSpecialization(name: item ?? '');
          },
          itemCount: trainer?.teacherSpecialization?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10,
            );
          },
        ));
  }
}
