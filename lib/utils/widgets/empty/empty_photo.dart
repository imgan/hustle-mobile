import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/oswald.dart';

class EmptyPhoto extends StatelessWidget {
  const EmptyPhoto(
      {super.key, required this.initialName, this.sizePhoto, this.sizeFont});

  final String initialName;
  final double? sizePhoto;
  final double? sizeFont;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizePhoto ?? 50.h,
      height: sizePhoto ?? 50.h,
      decoration: const ShapeDecoration(
        color: Colors.black,
        shape: OvalBorder(),
      ),
      child: Center(
        child: Text(
          initialName,
          textAlign: TextAlign.center,
          style: Oswald.bold.copyWith(
            color: Colors.white,
            fontSize: sizeFont ?? 16.sp,
          ),
        ),
      ),
    );
  }
}
