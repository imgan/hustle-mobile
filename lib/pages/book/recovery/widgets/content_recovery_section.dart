import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/recovery.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/recovery/recovery_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/grid_loading.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_description.dart';

import '../../trainer/widget/item_recovery.dart';
import '../detail/arg_recovery_detail.dart';
import '../detail/recovery_detail_page.dart';

class ContentRecoverySection extends StatelessWidget {
  const ContentRecoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecoveryController>();

    return GetBuilder<RecoveryController>(builder: (context) {
      return switch (controller.recoveryState.value) {
        LoadingState() => const GridLoading(
            childAspectRatio: 0.83,
            itemCount: 6,
          ),
        EmptyState() => const EmptyClass(
            text: 'Recovery not found',
          ),
        SuccessState<List<Recovery>>(result: var res) => RefreshIndicator(
            onRefresh: () {
              return controller.getRecovery();
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
              itemCount: res?.length ?? 0,
              itemBuilder: (context, index) {
                final recovery = res?[index];
                return ItemRecovery(
                  recovery: recovery,
                  onTap: () {
                    Get.to(
                        () => RecoveryDetailPage(
                              title: 'Recovery',
                            ),
                        arguments: {
                          ArgRecoveryDetail.sessionId: recovery?.sessionId,
                          ArgRecoveryDetail.sportClassId: recovery?.id,
                          ArgRecoveryDetail.title: 'Recovery'
                        });
                  },
                );
              },
            ),
          ),
        ErrorState(error: var err) => Center(
            child: TextDescription(
              description: err ?? '',
            ),
          ),
        _ => const SizedBox()
      };
    });
  }
}
