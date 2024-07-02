import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/profile/bookinghistory/cancelledclasspage/booking_cancelled_controller.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

import '../../../pages/book/class/detail/class_detail_page.dart';
import '../../../pages/book/class/status_book.dart';
import '../../../pages/book/recovery/detail/arg_recovery_detail.dart';
import '../../../pages/book/recovery/detail/recovery_detail_page.dart';
import '../../../pages/book/trainer/detail/trainer_detail.dart';
import '../../../utils/widgets/empty/empty_class.dart';
import '../widget/class_history_item.dart';

class CancelledClassTab extends StatelessWidget {
  CancelledClassTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final controller = Get.put(BookingCancelledController());

  @override
  Widget build(BuildContext context) {
    final isClass = controller.bookingHistory.isNotEmpty;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreBookingHistoryCancelled();
      }
    });

    return GetBuilder<BookingCancelledController>(builder: (context) {
      if (!(isClass)) {
        return const EmptyClass(
          text: 'There is no cancelled class.',
          image: 'assets/images/ic_no_completed_class.svg',
        );
      }
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListView.builder(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.bookingHistory.length,
                    itemBuilder: (context, index) {
                      final sessionId =
                          controller.bookingHistory[index].session?.id;
                      final memberId =
                          controller.bookingHistory[index].memberId;
                      final cancelledClass = controller.bookingHistory[index];
                      return ClassHistoryItem(
                        cancelledClass: cancelledClass,
                        isCompleted: false,
                        onTap: () {
                          switch (cancelledClass.session?.category) {
                            case 'class':
                              Get.to(() => ClassDetailPage(), arguments: {
                                ArgumentClassDetail.statusBook:
                                    StatusBook.cancelled,
                                ArgumentClassDetail.scheduleId: sessionId,
                                ArgumentClassDetail.memberSessionId: memberId,
                                ArgumentClassDetail.sportsClassId:
                                    cancelledClass.session?.sportsClassId
                              });
                              break;
                            case 'recovery':
                              Get.to(
                                  () => RecoveryDetailPage(
                                        title: 'Recovery',
                                      ),
                                  arguments: {
                                    ArgRecoveryDetail.sessionId: sessionId,
                                    ArgRecoveryDetail.sportClassId:
                                        cancelledClass.session?.sportsClassId,
                                    ArgRecoveryDetail.isCancelled: true
                                  });
                              break;
                            case 'wellness':
                              Get.to(
                                  () => RecoveryDetailPage(
                                        title: 'Wellness',
                                      ),
                                  arguments: {
                                    ArgRecoveryDetail.sessionId: sessionId,
                                    ArgRecoveryDetail.sportClassId:
                                        cancelledClass.session?.sportsClassId,
                                    ArgRecoveryDetail.isCancelled: true
                                  });
                              break;
                            case 'personal trainer':
                              Get.to(() => TrainerDetail(), arguments: {
                                ArgTrainerDetail.teacherId:
                                    cancelledClass.session?.teacherId,
                                ArgTrainerDetail.isCancelled: true,
                                ArgTrainerDetail.date: cancelledClass
                                    .session?.start
                                    .toString()
                                    .getDateSchedule()
                              });
                              break;
                            default:
                              debugPrint('Invalid category');
                            // Handle other cases here
                          }
                        },
                      );
                    },
                  ),
                ),
                if (controller.isLoadMore.value == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            )),
      );
    });
  }
}
