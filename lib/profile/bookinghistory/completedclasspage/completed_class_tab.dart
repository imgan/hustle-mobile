import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/arg_recovery_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/profile/bookinghistory/completedclasspage/completedclasscontroller/booking_completed_controller.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

import '../../../pages/book/class/detail/class_detail_page.dart';
import '../../../pages/book/class/status_book.dart';
import '../../../pages/book/recovery/detail/recovery_detail_page.dart';
import '../../../pages/book/trainer/detail/trainer_detail.dart';
import '../../../utils/widgets/empty/empty_class.dart';
import '../../../utils/widgets/loading/list_loading.dart';
import '../widget/class_history_item.dart';

class CompletedClassTab extends StatelessWidget {
  CompletedClassTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  final controller = Get.put(BookingCompletedController());

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreBookingHistoryCompleted();
      }
    });

    return GetBuilder<BookingCompletedController>(builder: (context) {
      final isClassEmpty = controller.bookingHistory.isEmpty;
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: const ListLoading(
            height: 180,
          ),
        );
      }
      if (isClassEmpty) {
        return const EmptyClass(
          text: 'There is no completed class.',
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
                        final completedClass = controller.bookingHistory[index];
                        return ClassHistoryItem(
                          completedClass: completedClass,
                          isCompleted: true,
                          onTap: () {
                            switch (completedClass.session?.category) {
                              case 'class':
                                Get.to(() => ClassDetailPage(), arguments: {
                                  ArgumentClassDetail.statusBook:
                                      StatusBook.completed,
                                  ArgumentClassDetail.scheduleId: sessionId,
                                  ArgumentClassDetail.memberSessionId: memberId,
                                  ArgumentClassDetail.sportsClassId:
                                      completedClass.session?.sportsClassId,
                                  ArgumentClassDetail.bookingHistoryId:
                                      completedClass.id,
                                  ArgumentClassDetail.isUserComment:
                                      completedClass.isUserComment ?? false
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
                                          completedClass.session?.sportsClassId,
                                      ArgRecoveryDetail.pathId:
                                          completedClass.id,
                                      ArgRecoveryDetail.isUserComment:
                                          completedClass.isUserComment ?? false
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
                                          completedClass.session?.sportsClassId,
                                      ArgRecoveryDetail.pathId:
                                          completedClass.id,
                                      ArgRecoveryDetail.isUserComment:
                                          completedClass.isUserComment ?? false
                                    });
                                break;
                              case 'personal trainer':
                                Get.to(() => TrainerDetail(), arguments: {
                                  ArgTrainerDetail.teacherId:
                                      completedClass.session?.teacherId,
                                  ArgTrainerDetail.pathId: completedClass.id,
                                  ArgTrainerDetail.isUserComment:
                                      completedClass.isUserComment ?? false,
                                  ArgTrainerDetail.date: completedClass
                                      .session?.start
                                      .toString()
                                      .getDateSchedule()
                                });
                                break;
                              default:
                                Get.to(() => TrainerDetail(), arguments: {
                                  ArgTrainerDetail.teacherId:
                                      completedClass.session?.teacherId,
                                  ArgTrainerDetail.pathId: completedClass.id,
                                  ArgTrainerDetail.isUserComment:
                                      completedClass.isUserComment ?? false,
                                  ArgTrainerDetail.date: completedClass
                                      .session?.start
                                      .toString()
                                      .getDateSchedule()
                                });
                                break;
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
              )));
    });
  }
}
