import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/review/review_controller.dart';
import 'package:hustle_house_flutter/pages/review/widget/review_user_section.dart';
import 'package:hustle_house_flutter/pages/review/widget/total_review_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../utils/colors.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});

  final ReviewController controller = Get.put(ReviewController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.80 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreReview();
      }
    });
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'All Reviews',
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const TotalReviewSection(),
            Divider(
              color: gray1,
              thickness: 1,
            ),
            const ReviewUserSection()
          ],
        ),
      ),
    );
  }
}
