import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/register/register_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';

class PopUpTnC extends StatelessWidget {
  PopUpTnC({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final term = controller.termConditionData[0];
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Terms & Conditions',
            textAlign: TextAlign.center,
            style: DDinExp.black.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: gray2,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                term.title1,
                textAlign: TextAlign.start,
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                term.description1,
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Decline',
                  colorButton: Colors.white,
                  borderSideColor: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(
                width: 9,
              ),
              Expanded(
                child: PrimaryButton(
                  text: 'Accept',
                  onPressed: () {
                    controller.changeIsCheckTnC(value: true);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
