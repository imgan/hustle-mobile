import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/typography/d_din_exp.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            size: 28.h,
          ),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        Expanded(
          child: Text(
            'Checkout',
            textAlign: TextAlign.center,
            style: DDinExp.bold.copyWith(color: Colors.black, fontSize: 16.sp),
          ),
        ),
         SizedBox(
          width: 40.h,
        ),
      ],
    );
  }
}
