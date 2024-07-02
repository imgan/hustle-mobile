import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../../utils/colors.dart';
import '../../../notification/notification_page.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      return InkWell(
        onTap: () {
          Get.to(() => NotificationPage());
        },
        child: Container(
          width: 44.h,
          height: 44.h,
          margin:  EdgeInsets.only(right: 14.h),
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/ic_notification.svg",
                width: 24.w,
                height: 24.h,
              ),
              Visibility(
                visible: controller.isNewNotification.isTrue,
                child: Positioned(
                  right: 2,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: red, // inner circle color
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
