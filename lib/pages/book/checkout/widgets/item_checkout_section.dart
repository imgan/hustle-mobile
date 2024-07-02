import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/image/image_cover.dart';

import '../../../../utils/widgets/empty/empty_photo.dart';
import '../../../../utils/widgets/my_credit.dart';

class ItemCheckoutSection extends StatelessWidget {
  const ItemCheckoutSection(
      {super.key,
      required this.isClass,
      required this.imageUrl,
      required this.name,
      required this.hour,
      required this.date,
      required this.trainer,
      required this.location,
      required this.total});

  final bool isClass;
  final String imageUrl;
  final String name;
  final String hour;
  final String date;
  final String trainer;
  final String location;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _image(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name • $hour',
                  style: DDinExp.black
                      .copyWith(color: Colors.black, fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(date,
                            style: DDinExp.regular
                                .copyWith(color: Colors.black, fontSize: 14.sp)),
                        Visibility(
                          visible: isClass,
                          child: Text(trainer,
                              style: DDinExp.regular.copyWith(
                                  color: Colors.black, fontSize: 14.sp)),
                        ),
                        SizedBox(height: 5.h),
                        Visibility(
                          visible: false,
                          child: Text(
                            location,
                            style: DDinExp.regular
                                .copyWith(color: Colors.black, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 3.h),
                    MyCredit(
                      credit: total,
                      iconSize: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    if (isClass) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h),
        child: ImageCover(
          height: 50.h,
          width: 50.h,
          url: imageUrl,
        ),
      );
    }
    final fullName = name.split(' ');
    final firstName = fullName[0][0];
    final lastName = (fullName.length) > 1 ? fullName[1][0] : '';
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: ImageCover(
          height: 50.h,
          width: 50.h,
          url: imageUrl,
          errorWidget: Center(
              child: EmptyPhoto(
            initialName: '$firstName$lastName',
          )),
        ));
  }
}
