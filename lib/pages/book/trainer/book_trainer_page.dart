import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/trainer_controller.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/item_trainer.dart';

class BookTrainerPage extends StatelessWidget {
  BookTrainerPage({super.key});

  final TrainerController controller = Get.put(TrainerController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    loadMoreTrainer();
    return GetBuilder<TrainerController>(builder: (_) {
      return RefreshIndicator(
        onRefresh: () {
          return controller.getTrainer();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: const EdgeInsets.all(14),
            child: Column(
              children: [
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.trainers.length,
                  itemBuilder: (context, idx) {
                    final trainer = controller.trainers[idx];
                    return ItemTrainer(
                      trainer: trainer,
                      onTap: () {
                        Get.to(() => TrainerDetail(),
                            arguments: {ArgTrainerDetail.teacherId: trainer.id});
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void loadMoreTrainer() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.80 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreTrainer();
      }
    });
  }
}
