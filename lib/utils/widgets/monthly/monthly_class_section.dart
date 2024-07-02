import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/loading/loading.dart';
import '../../../pages/bookingclass/onemonthpackagelist/package_page.dart';

class MonthlyClassSection extends StatelessWidget {
  const MonthlyClassSection(
      {super.key,
      required this.isLoading,
      required this.title,
      required this.description,
      this.isPurchase});

  final bool isLoading;
  final String title;
  final String description;
  final bool? isPurchase;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: Loading(
          height: 145.h,
        ),
      );
    }
    return InkWell(
      onTap: () {
        Get.to(() => const PackagePage());
      },
      child: Container(
        padding: EdgeInsets.all(14.h),
        margin: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
        decoration: ShapeDecoration(
          color: (isPurchase ?? false) ? Colors.white : primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  width: 1.0,
                  color: (isPurchase ?? false) ? disableColor : primaryColor)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DDinExp.bold.copyWith(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    description,
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right_rounded,
              color: (isPurchase ?? false) ? Colors.black : primaryDarkColor2,
              size: 28.h,
            )
          ],
        ),
      ),
    );
  }
}
