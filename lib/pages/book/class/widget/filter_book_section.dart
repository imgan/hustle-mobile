import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../book_class_controller.dart';
import 'pop_up_filter.dart';

class FilterBookSection extends StatelessWidget {
  const FilterBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (_) {
      return InkWell(
        onTap: () {
          controller.updateClasses();
          Get.dialog(PopUpFilter());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
          margin:
              const EdgeInsets.only(bottom: 20, top: 14, left: 14, right: 14),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: disableColor),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Filter',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 10.h),
              Visibility(
                visible: controller.totalFilter > 0,
                child: SizedBox(
                  width: 24.h,
                  height: 24.h,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 24.h,
                          height: 24.h,
                          decoration: ShapeDecoration(
                            color: primaryColor,
                            shape: const OvalBorder(),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          controller.totalFilter.value.toString(),
                          style: DDinExp.regular.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/images/ic_filter.svg",
                width: 24.w,
                height: 24.h,
              )
            ],
          ),
        ),
      );
    });
  }
}
