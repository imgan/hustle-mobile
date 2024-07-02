import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/book_recovery_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/extension/string.dart';
import '../../../../../utils/widgets/loading/loading.dart';
import '../../../trainer/widget/item_schedule_wellness.dart';

class ScheduleTimeRecoverySection extends StatelessWidget {
  const ScheduleTimeRecoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookRecoveryController>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      child: GetBuilder<BookRecoveryController>(builder: (_) {
        return switch (controller.scheduleTimeState.value) {
          LoadingState() => const Loading(
              height: 72,
            ),
          EmptyState() => const EmptyClass(
              text: 'Schedule time not found',
            ),
          SuccessState() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Session',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          controller.updateShowSession();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: disableColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.currentKey.value,
                                style: DDinExp.regular.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset("assets/images/ic_down.svg")
                            ],
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: SafeArea(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: disableColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.getScheduleTimes().length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                String key = controller
                                    .getScheduleTimes()
                                    .keys
                                    .toList()[index];
                                return ItemScheduleWellness(
                                  name: key,
                                  isSelected:
                                      controller.currentSessionIndex.value ==
                                          index,
                                  onTap: () {
                                    controller.updateSessionIndex(key, index,
                                        controller.getScheduleTimes());
                                    controller.updateShowSession();
                                    controller.sessionSubTotal();
                                    controller.checkStatusBook();
                                    controller.checkStatusCancel();
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          ),
                        ),
                        secondChild: Container(),
                        crossFadeState: controller.isShowSession.isTrue
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Time',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          controller.updateShowTime();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: disableColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.currentTime.value,
                                style: DDinExp.regular.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset("assets/images/ic_down.svg")
                            ],
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: SafeArea(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: disableColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller
                                      .getScheduleTimes()[
                                          controller.currentKey.value]
                                      ?.length ??
                                  0,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final scheduleTime =
                                    controller.getScheduleTimes()[
                                        controller.currentKey.value]?[index];
                                return ItemScheduleWellness(
                                  name: scheduleTime?.startTime?.formatHour() ??
                                      '',
                                  isSelected: controller.currentTimeId.value ==
                                      scheduleTime?.id,
                                  onTap: () {
                                    controller.updateTimeIndex(
                                        scheduleTime?.startTime?.formatHour() ??
                                            '',
                                        scheduleTime?.id ?? 0,
                                        scheduleTime?.memberSession?.id ?? 0);
                                    controller.updateShowTime();
                                    controller.sessionSubTotal();
                                    controller.checkStatusBook(index: index);
                                    controller.checkStatusCancel();
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          ),
                        ),
                        secondChild: Container(),
                        crossFadeState: controller.isShowTime.isTrue
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      )
                    ],
                  ),
                )
              ],
            ),
          _ => const SizedBox()
        };
      }),
    );
  }
}
