import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.height, this.width, this.marginHorizontal});

  final double? height;
  final double? width;
  final double? marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal ?? 14),
      child: Shimmer.fromColors(
        baseColor: disableColor,
        highlightColor: gray1,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 50,
          decoration: BoxDecoration(
            color: gray2,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

}