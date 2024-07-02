import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/custom_dialog.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: GetBuilder<HomeController>(builder: (context) {
        final bookingHistory = controller.bookingHistoryCompleted.value;
        if (bookingHistory != null) {
          return Container(
            margin: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/ic_kiss_my_abs.svg",
                    ),
                    Column(
                      children: [
                        Text(
                          bookingHistory.session?.sportsClass?.name ??
                              '${bookingHistory.session?.teacher?.firstName} ${bookingHistory.session?.teacher?.lastName}',
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          controller.getDateSchedule(
                              bookingHistory.session?.start.toString() ?? ''),
                          style: DDinExp.regular.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Divider(
                  color: disableColor,
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'What do you think about this ${bookingHistory.session?.category}?',
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(CustomDialog().rating(rate: (rate, comment) {
                      controller.reviewClass(rate: '$rate', comment: comment);
                    }));
                  },
                  child: RatingBar(
                    initialRating: 0,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: gold,
                      ),
                      half: Icon(Icons.star_half, color: gold),
                      empty: Icon(Icons.star_border, color: gold),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                const SizedBox(
                  height: 14,
                )
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
