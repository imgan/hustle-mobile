import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/status_notify.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class NotifyDetailSection extends StatelessWidget {
  const NotifyDetailSection({super.key, required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Get notified when a spot becomes available',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                const StatusNotify()
              ],
            ),
          ),
          Divider(
            color: gray1,
            thickness: 1.h,
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
