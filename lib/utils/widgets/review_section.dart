import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/comment.dart';
import 'package:hustle_house_flutter/model/review.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../pages/review/review_page.dart';
import '../colors.dart';
import '../extension/string.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection(
      {super.key, this.review, this.comment, this.id, this.isVisible});

  final Review? review;
  final Comment? comment;
  final String? id;
  final bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Reviews',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    '${review?.averageRating?.toStringAsFixed(1)}',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 14.h,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '(${review?.totalRatings})',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(14.h),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.h, color: disableColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${comment?.firstName} ${comment?.lastName}',
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          comment?.createdAt?.getTimeAgo() ?? '',
                          style: DDinExp.regular.copyWith(
                            color: const Color(0xFF6D6D6D),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBar(
                    itemSize: 20.h,
                    initialRating: comment?.starRating?.toDouble() ?? 0.0,
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
                  const SizedBox(height: 10),
                  Text(
                    comment?.comments ?? '',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 14.h, bottom: 20.h),
              child: InkWell(
                onTap: () {
                  Get.to(() => ReviewPage(), arguments: [id]);
                },
                child: Text(
                  'See all reviews',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
