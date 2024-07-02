import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

import '../../../../utils/colors.dart';
import '../status_book.dart';

class StatusNotify extends StatelessWidget {
  const StatusNotify({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassDetailController>();
    return GetBuilder<ClassDetailController>(builder: (_) {
      final isNotify = controller.isNotify();
      if (controller.isLoadingNotify.isTrue) {
        return Loading(
          width: 108.w,
          height: 40.h,
        );
      }
      switch (controller.statusBook.value) {
        case StatusBook.notify:
          return InkWell(
            onTap: () {
              controller.updateStatusNotify(isNotify);
            },
            child: Container(
              padding: EdgeInsets.all(10.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.h, color: gray1),
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
            onTap: () {
              controller.updateStatusNotify(isNotify);
            },
            child: Container(
              padding: EdgeInsets.all(10.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.h, color: gray1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: SvgPicture.asset(
                "assets/images/ic_active_notification.svg",
                width: 20.h,
                height: 20.h,
              ),
            ),
          );
        default:
          return Container();
      }
    });
  }
}
