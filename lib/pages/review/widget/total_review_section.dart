import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/review/review_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';
import 'item_rate_percentage.dart';
import 'loading_review.dart';

class TotalReviewSection extends StatelessWidget {
  const TotalReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(builder: (_) {
      final controller = Get.find<ReviewController>();
      final review = controller.review.value;
      if (controller.isLoadingReview.isTrue) {
        return const LoadingReview();
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${review?.averageRating?.toStringAsFixed(1)}',
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 34,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar(
                  itemSize: 14,
                  initialRating: review?.averageRating?.toDouble() ?? 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: gold,
                    ),
                    half: Icon(Icons.star_half, color: gold),
                    empty: Icon(Icons.star_border, color: gold),
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${review?.totalRatings}',
                  textAlign: TextAlign.center,
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String number = (5 - index).toString();
                double? percent;
                try {
                  percent =
                      (controller.getPercentage()[int.parse(number)] ?? 0.0) /
                          100;
                } catch (e) {
                  percent = 0.0;
                }
                return ItemRatePercentage(
                  number: number,
                  percent: percent,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8.5,
                );
              },
            ),
          ),
          const SizedBox(
            width: 14,
          ),
        ],
      );
    });
  }
}
