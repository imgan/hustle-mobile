import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/package_first_timer.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_page.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/extension/int.dart';
import '../../../../utils/widgets/loading/loading.dart';
import '../../../../utils/widgets/primary_button.dart';

class ItemListMonthPackage extends StatelessWidget {
  const ItemListMonthPackage({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: disableColor)),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 196,
            margin: const EdgeInsets.only(bottom: 15),
            //color: Colors.blue,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  imageUrl: package.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Loading(
                        marginHorizontal: 0,
                      ),
                  errorWidget: (context, url, error) => const Center(
                          child: Icon(
                        Icons.error,
                      ))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  package.name ?? '',
                  style: DDinExp.extraBold.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: disableColor)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_credit.svg',
                        height: 18,
                        width: 12,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${package.price} Credits',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                (package.expiry ?? 0) <= 30
                    ? 'Valid for ${package.expiry} days'
                    : 'Valid for ${package.expiry?.parseMonth()} month',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: PrimaryButton(
              text: 'See Details',
              elevation: 0,
              onPressed: () {
                Get.to(() => PackageDetailPage(), arguments: [package.id]);
              },
            ),
          )
        ],
      ),
    );
  }
}
