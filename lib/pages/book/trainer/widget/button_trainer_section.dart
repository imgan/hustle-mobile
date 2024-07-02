import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import '../../../../model/trainer.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/dialog/cancel_dialog.dart';
import '../../../../utils/widgets/floating_button.dart';
import '../book/book_pt_page.dart';

class ButtonTrainerSection extends StatelessWidget {
  const ButtonTrainerSection({super.key, required this.trainer});

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return GetBuilder<TrainerDetailController>(builder: (_) {
      if (controller.isRateClass()) {
        return FloatingButton(
          text: "Rate Class",
          onPressed: () {
            Get.dialog(CustomDialog().rating(rate: (rate, comment) {
              controller.reviewTrainer(rate: '$rate', comment: comment);
            }));
          },
        );
      }
      if (controller.isCancel.isTrue) {
        return FloatingButton(
          text: 'Cancel',
          colorButton: Colors.white,
          textColor: red,
          borderColor: red,
          onPressed: () {
            Get.dialog(CancelDialog(
                title: 'Cancel Booking',
                subTitle: controller.isReturnCredit.isFalse
                    ? 'Are you sure you want to cancel this booking?'
                    : 'Are you sure you want to cancel this booking? Your credits will be returned.',
                message: controller.isReturnCredit.isFalse
                    ? 'Your credits will not be returned'
                    : '',
                onTap: () {
                  controller.cancelBook();
                }));
          },
        );
      }
      return Visibility(
        visible: !controller.isCancelled() && !isFromBookingHistory,
        child: FloatingButton(
          text: 'Check Availability',
          onPressed: () {
            Get.to(
                () => BookPTPage(
                      trainer: '${trainer?.firstName} ${trainer?.lastName}',
                      price: trainer?.price.toString() ?? '0',
                    ),
                arguments: [trainer?.id]);
          },
        ),
      );
    });
  }
}
