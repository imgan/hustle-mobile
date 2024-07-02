import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/book_pt_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/grid_loading.dart';

import '../../../../../utils/extension/string.dart';
import '../../widget/item_schedule.dart';

class ScheduleTimePTSection extends StatelessWidget {
  const ScheduleTimePTSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookPTController>();
    return GetBuilder<BookPTController>(builder: (_) {
      return switch (controller.scheduleTimeState.value) {
        LoadingState() => const GridLoading(),
        EmptyState() => const EmptyClass(
            text: 'Schedule time not found',
          ),
        SuccessState() => Container(
            margin: const EdgeInsets.only(top: 8, left: 14, right: 14),
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.scheduleTimes.length,
              itemBuilder: (context, index) {
                var scheduleTime = controller.scheduleTimes[index];
                return ItemSchedule(
                  time: scheduleTime.startTime?.formatHour() ?? '',
                  isSelected:
                      controller.currentScheduleId.value == scheduleTime.id,
                  isDisable: scheduleTime.status == "Booked",
                  onTap: () {
                    controller.updateScheduleId(scheduleTime.id ?? 0);
                    controller.checkStatusBook(index: index);
                    controller.sessionSubTotal();
                    controller.updateMemberSessionId(
                        scheduleTime.memberSession?.id ?? 0);
                  },
                );
              },
            ),
          ),
        _ => const SizedBox()
      };
    });
  }
}
