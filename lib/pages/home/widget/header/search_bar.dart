import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../../../search/search_page.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchPage());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 28, left: 14, right: 14, bottom: 28),
        padding: EdgeInsets.all(10.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_search.svg",
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 10.h),
            Text(
              'Search something',
              textAlign: TextAlign.center,
              style: DDinExp.regular.copyWith(
                color: gray2,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
