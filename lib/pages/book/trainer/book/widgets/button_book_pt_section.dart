import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/book_pt_controller.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets/dialog/cancel_dialog.dart';
import '../../../../../utils/widgets/floating_button.dart';
import '../../../widgets/notify_section.dart';

class ButtonBookPTSection extends StatelessWidget {
  const ButtonBookPTSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookPTController>();
    return GetBuilder<BookPTController>(builder: (context) {
      if (controller.isShowNotify()) {
        return NotifySection(
          isNotify: controller.isNotify(),
          isLoading: controller.isLoadingNotify.isTrue,
          onTap: () {
            controller.updateNotify();
          },
        );
      }

      if (controller.isBooked()) {
        return FloatingButton(
            text: 'Cancel Booking',
            colorButton: Colors.white,
            borderColor: red,
            textColor: red,
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
            });
      }
      return FloatingButton(
        text: 'Book Now',
        isDisable: controller.isCanBook.isFalse,
        onPressed: () {
          controller.getBook();
        },
      );
    });
  }
}
