import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/pages/home/widget/item_category_class.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemClass extends StatelessWidget {
  const ItemClass({super.key, this.sportClass, this.onTap});

  final SportClass? sportClass;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width / 1.19,
        margin: const EdgeInsets.only(bottom: 14),
        clipBehavior: Clip.none,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(10, 0),
            ),
          ],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                height: 200.h,
                imageUrl: sportClass?.imageUrl ?? '',
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    )),
            Container(
                clipBehavior: Clip.none,
                margin: const EdgeInsets.all(14),
                child: RichText(
                  text: TextSpan(
                    style: DDinExp.extraBold.copyWith(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                    children: [
                      TextSpan(
                        text: sportClass?.name ?? '',
                      ),
                      TextSpan(
                        text: ' (${sportClass?.duration ?? 0} Min)',
                        style: DDinExp.extraBold.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: Get.width > 600 ? 38.h : 32.h,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final sportClassType = sportClass?.sportsClassType?[index];
                    return ItemCategoryClass(
                      sportsClassType: sportClassType,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10.h,
                    );
                  },
                  itemCount: sportClass?.sportsClassType?.length ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
