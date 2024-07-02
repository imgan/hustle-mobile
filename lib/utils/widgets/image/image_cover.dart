import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../loading/loading.dart';

class ImageCover extends StatelessWidget {
  const ImageCover(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.errorWidget});

  final String url;
  final double? height;
  final double? width;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? Get.width,
      height: height ?? 214.h,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Loading(
        marginHorizontal: 0,
      ),
      errorWidget: (context, url, error) =>
          errorWidget ?? const Center(child: Icon(Icons.error)),
    );
  }
}
