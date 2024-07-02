import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/booking_history.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/empty/empty_photo.dart';
import '../../../utils/widgets/loading/loading.dart';

class ClassHistoryItem extends StatelessWidget {
  const ClassHistoryItem({
    super.key,
    required this.onTap,
    this.completedClass,
    this.cancelledClass,
    this.isCompleted,
  });

  final VoidCallback onTap;
  final BookingHistory? completedClass;
  final BookingHistory? cancelledClass;
  final bool? isCompleted;

  @override
  Widget build(BuildContext context) {
    final sessionTime = isCompleted ?? false
        ? completedClass?.session?.start
        : cancelledClass?.session?.start;
    final bool isTrainer = isCompleted ?? false
        ? completedClass?.session?.category == "personal trainer"
        : cancelledClass?.session?.category == "personal trainer";
    final bool isClass = isCompleted ?? false
        ? completedClass?.session?.category == "class"
        : cancelledClass?.session?.category == "class";
    final DateFormat formatter = DateFormat.EEEE();
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final DateFormat hourFormat = DateFormat('HH:mm');
    final firstName = isCompleted ?? false
        ? completedClass?.session?.teacher?.firstName?.toUpperCase()[0] ?? ''
        : cancelledClass?.session?.teacher?.firstName?.toUpperCase()[0] ?? '';
    final lastName = isCompleted ?? false
        ? completedClass?.session?.teacher?.lastName?.toUpperCase()[0] ?? ''
        : cancelledClass?.session?.teacher?.lastName?.toUpperCase()[0] ?? '';

    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1, color: disableColor),
            top: BorderSide(width: 1, color: disableColor),
            right: BorderSide(width: 1, color: disableColor),
            bottom: BorderSide(width: 1, color: disableColor),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(14),
            child: Row(
              children: [
                isTrainer
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl: isCompleted ?? false
                              ? completedClass?.session?.teacher?.imageUrl ?? ''
                              : cancelledClass?.session?.teacher?.imageUrl! ??
                                  '',
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Loading(
                            marginHorizontal: 0,
                          ),
                          errorWidget: (context, url, error) {
                            return Center(
                                child: EmptyPhoto(
                              initialName: '$firstName$lastName',
                              sizeFont: 25,
                            ));
                          },
                        ),
                      )
                    : CachedNetworkImage(
                        width: 50,
                        height: 50,
                        imageUrl: isCompleted ?? false
                            ? completedClass?.session?.sportsClass
                                    ?.sportsClassAsset?.logoUrl ??
                                ''
                            : cancelledClass?.session?.sportsClass
                                    ?.sportsClassAsset?.logoUrl ??
                                '',
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Loading(
                          marginHorizontal: 0,
                        ),
                        errorWidget: (context, url, error) {
                          return Center(
                              child: EmptyPhoto(
                            initialName: '$firstName$lastName',
                            sizeFont: 25,
                          ));
                        },
                      ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: isCompleted ?? false
                                  ? completedClass
                                          ?.session?.sportsClass?.name ??
                                      "${completedClass?.session?.teacher?.firstName} ${completedClass?.session?.teacher?.lastName}"
                                  : cancelledClass
                                          ?.session?.sportsClass?.name ??
                                      "${cancelledClass?.session?.teacher?.firstName} ${cancelledClass?.session?.teacher?.lastName}",
                              style: DDinExp.semiBold.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: " ${hourFormat.format(sessionTime!)}",
                              style: DDinExp.semiBold.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${formatter.format(sessionTime)}, ${dateFormat.format(sessionTime)}",
                        style: DDinExp.regular.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: isClass ? 3 : 0,
                      ),
                      if (isClass)
                        Text.rich(
                          TextSpan(
                            children: [
                              if (isCompleted ?? false
                                  ? completedClass
                                          ?.session?.sportsClass?.duration !=
                                      null
                                  : cancelledClass
                                          ?.session?.sportsClass?.duration !=
                                      null)
                                TextSpan(
                                  text:
                                      "${isCompleted ?? false ? completedClass?.session?.sportsClass?.duration : cancelledClass?.session?.sportsClass?.duration} Min \u2022 ",
                                  style: DDinExp.regular.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              TextSpan(
                                text:
                                    "${isCompleted ?? false ? completedClass?.session?.teacher?.firstName ?? '' : cancelledClass?.session?.teacher?.firstName ?? ''} ${isCompleted ?? false ? completedClass?.session?.teacher?.lastName == "Specified" ? "" : completedClass?.session?.teacher?.lastName ?? '' : cancelledClass?.session?.teacher?.lastName == "Specified" ? "" : cancelledClass?.session?.teacher?.lastName ?? ''}",
                                style: DDinExp.regular.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      /**
                       * Temporary hide
                       */
                      // Text(
                      //   "${isCompleted ?? false ? completedClass?.session?.location?.locationName : cancelledClass?.session?.location?.locationName}",
                      //   style: DDinExp.regular.copyWith(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      if (isCompleted ?? false)
                        RatingBar(
                          itemSize: 20,
                          initialRating: isCompleted ?? false
                              ? completedClass?.averageRating ?? 0
                              : cancelledClass?.averageRating ?? 0,
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
                    ],
                  ),
                ),
                if (isCompleted ?? false
                    ? completedClass?.session?.sportsClass?.rewardPoints !=
                            null ||
                        completedClass?.session?.teacher?.rewardPoint != null
                    : cancelledClass?.session?.sportsClass?.rewardPoints !=
                            null ||
                        cancelledClass?.session?.teacher?.rewardPoints != null)
                  Container(
                    transform: Matrix4.translationValues(
                        0.0, (isCompleted ?? false) ? 30.0 : 10.0, 0.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(width: 1, color: disableColor),
                          top: BorderSide(width: 1, color: disableColor),
                          right: BorderSide(width: 1, color: disableColor),
                          bottom: BorderSide(width: 1, color: disableColor),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: SvgPicture.asset(
                              'assets/images/ic_award.svg',
                              height: 14,
                              width: 14,
                            )),
                            TextSpan(
                              text:
                                  "  +${isCompleted ?? false ? (!isTrainer ? completedClass?.session?.sportsClass?.rewardPoints : completedClass?.session?.teacher?.rewardPoint) : (!isTrainer ? cancelledClass?.session?.sportsClass?.rewardPoints : cancelledClass?.session?.teacher?.rewardPoints)}",
                              style: DDinExp.regular.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: disableColor, thickness: 1, height: 1,),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 17),

            child: InkWell(
              onTap: onTap,
              child: Text(
                'View Details',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
