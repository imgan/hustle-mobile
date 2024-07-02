import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/recovery.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/wellness/wellness_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/location/pop_up_location_wellness.dart';

import '../../../utils/widgets/filter_location.dart';
import '../../../utils/widgets/loading/loading.dart';
import '../recovery/detail/arg_recovery_detail.dart';
import '../recovery/detail/recovery_detail_page.dart';
import '../trainer/widget/item_recovery.dart';

class WellnessPage extends StatelessWidget {
  WellnessPage({super.key});

  final WellnessController controller = Get.put(WellnessController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WellnessController>(builder: (_) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            children: [
              FilterLocation(
                text: controller
                    .locationWellnessController.selectedLocationName.value,
                onTap: () {
                  controller.locationWellnessController.updatePopUpLocations();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [_content(), PopUpLocationWellness()],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _content() {
    return switch (controller.wellnessState.value) {
      LoadingState() => GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.848,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return const Loading(
              marginHorizontal: 0,
            );
          },
        ),
      EmptyState() => const EmptyClass(
          text: 'Wellness not found',
        ),
      ErrorState(error: var err) => Center(
          child: Text(
            err ?? '',
            textAlign: TextAlign.center,
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      SuccessState<List<Recovery>>(result: var res) => RefreshIndicator(
          onRefresh: () {
            return controller.getWellness();
          },
          child: GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.848,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: res?.length,
            itemBuilder: (context, index) {
              final recovery = res?[index];
              return ItemRecovery(
                recovery: recovery,
                onTap: () {
                  Get.to(
                      () => RecoveryDetailPage(
                            title: 'Wellness',
                          ),
                      arguments: {
                        ArgRecoveryDetail.sessionId: recovery?.sessionId,
                        ArgRecoveryDetail.sportClassId: recovery?.id,
                        ArgRecoveryDetail.title: 'Wellness',
                      });
                },
              );
            },
          ),
        ),
      _ => const SizedBox()
    };
  }
}
