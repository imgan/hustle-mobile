import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/review/review_controller.dart';

import '../../../utils/colors.dart';
import 'item_review.dart';

class ReviewUserSection extends StatelessWidget {
  const ReviewUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(builder: (_) {
      final controller = Get.find<ReviewController>();
      return ListView.separated(
        itemCount: controller.comments.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final comment = controller.comments[index];
          return ItemReview(
            comment: comment,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: gray1,
            thickness: 1,
          );
        },
      );
    });
  }
}
