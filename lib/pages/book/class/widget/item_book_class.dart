import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/schedule.dart';
import 'package:hustle_house_flutter/pages/book/class/status_book.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/widgets/my_credit.dart';
import 'package:intl/intl.dart';

import '../../../../utils/typography/d_din_exp.dart';
import '../../../../utils/widgets/loading/loading.dart';

class ItemBookClass extends StatelessWidget {
  const ItemBookClass(
      {super.key,
      this.color = Colors.black,
      this.statusBook = StatusBook.book,
      this.schedule,
      this.isLoadingCredit,
      this.onTap});

  final Color? color;
  final StatusBook? statusBook;
  final Schedule? schedule;
  final bool? isLoadingCredit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('yyyy-MM-dd HH:mm').parse(schedule?.start ?? '');
    var formatDate = DateFormat('HH:mm').format(date);
    return Container(
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: disableColor),
          top: BorderSide(width: 1, color: disableColor),
          right: BorderSide(color: disableColor),
          bottom: BorderSide(width: 1, color: disableColor),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
              height: 50.h,
              width: 50.h,
              imageUrl: schedule?.sportsClass?.sportsClassAsset?.logoUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Loading(
                    marginHorizontal: 0,
                  ),
              errorWidget: (context, url, error) => Center(
                      child: Icon(
                    Icons.error,
                    size: 50.h,
                  ))),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${schedule?.sportsClass?.name} • $formatDate',
                  style: DDinExp.bold.copyWith(
                    color: color,
                    fontSize: 16.sp,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${schedule?.sportsClass?.duration} mins • ${schedule?.teacher?.firstName}',
                  style: DDinExp.regular.copyWith(
                    color: color,
                    fontSize: 14.sp,
                  ),
                ),
                /**
                 * Temporary hide
                 */
                // const SizedBox(height: 10,),
                // Text(
                //   'Class capacity: ${schedule?.slotTaken}/${schedule?.quota}',
                //   style: DDinExp.regular.copyWith(
                //     color: color,
                //     fontSize: 14.sp,
                //   ),
                // )
                /**
                 * Temporary hide
                 */
                // SizedBox(
                //   height: 12.h,
                // ),
                // Row(
                //   children: [
                //     SvgPicture.asset(
                //       "assets/images/ic_location.svg",
                //       width: 20.h,
                //       height: 20.h,
                //     ),
                //     SizedBox(
                //       width: 5.h,
                //     ),
                //     Text(
                //       schedule?.location?.locationName ?? '',
                //       style: DDinExp.regular.copyWith(
                //         color: gray,
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          SizedBox(width: 3.h),
          _statusBook()
        ],
      ),
    );
  }

  Widget _statusBook() {
    if (isLoadingCredit ?? false) {
      return Loading(
        width: 57.h,
        height: 32.h,
      );
    }
    switch (statusBook) {
      case StatusBook.book:
        return MyCredit(credit: schedule?.price.toString(), iconSize: 23.h);
      case StatusBook.notify:
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: gray),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Notify me',
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  "assets/images/ic_notification.svg",
                  width: 20.h,
                  height: 20.h,
                )
              ],
            ),
          ),
        );
      case StatusBook.notified:
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: gray),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: SvgPicture.asset(
              "assets/images/ic_active_notification.svg",
            ),
          ),
        );
      case StatusBook.booked:
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: gray),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Booked',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
