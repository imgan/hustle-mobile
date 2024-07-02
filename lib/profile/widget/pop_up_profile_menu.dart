import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';
import '../../utils/typography/d_din_exp.dart';

class PopUpProfileMenu extends StatelessWidget {
  const PopUpProfileMenu({
    super.key,
    required this.title,
    required this.description,
    required this.command,
    required this.onTap,
  });

  final String title;
  final String description;
  final String command;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding:
          const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 15),
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.close_rounded,
              size: 28,
              color: Colors.black,
            ),
          )
        ],
      ),
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        width: Get.width,
        height: Get.height < 800 ? Get.height / 5 : Get.height / 5.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: EdgeInsets.zero,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: disableColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      command,
                      style: DDinExp.bold.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    PrimaryButton(
                      borderRadiusSize: 30,
                      sizeHeight: 35,
                      elevation: 0,
                      text: 'Go',
                      onPressed: onTap,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
