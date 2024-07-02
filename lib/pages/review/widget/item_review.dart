import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/comment.dart';
import '../../../utils/colors.dart';
import '../../../utils/extension/string.dart';

class ItemReview extends StatelessWidget {
  const ItemReview(
      {super.key,
      this.onTap,
      this.isResponse,
      this.isShowResponse,
      this.comment});

  final VoidCallback? onTap;
  final bool? isResponse;
  final bool? isShowResponse;
  final Comment? comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${comment?.firstName} ${comment?.lastName}',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                comment?.createdAt?.getTimeAgo() ?? '',
                style: DDinExp.regular.copyWith(
                  color: gray,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 14),
            ],
          ),
          const SizedBox(height: 10),
          RatingBar(
            itemSize: 20,
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
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 12.5,
          ),
          Visibility(
            visible: false,
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Hustle Response',
                        style: DDinExp.regular.copyWith(
                          color: gray,
                          fontSize: 14,
                        ),
                      ),
                      SvgPicture.asset(
                          isShowResponse ?? false
                              ? "assets/images/ic_up.svg"
                              : "assets/images/ic_down.svg",
                          colorFilter: ColorFilter.mode(gray, BlendMode.srcIn))
                    ],
                  ),
                  Visibility(
                    visible: isShowResponse ?? false,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: disableColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hustle Response',
                            style: DDinExp.bold.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur. Nunc venenatis vivamus sollicitudin id diam. Consequat sed nunc sit tellus pellentesque pretium egestas faucibus in. Eu ut ultrices duis donec faucibus habitant elit eros enim. Interdum interdum lorem orci natoque.',
                            style: DDinExp.regular.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
