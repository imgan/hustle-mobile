import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/package_first_timer.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../../utils/extension/int.dart';
import '../../../../../utils/widgets/my_credit.dart';
import '../../../../../utils/widgets/package_duration.dart';

class TitlePackageSection extends StatelessWidget {
  const TitlePackageSection({super.key, required this.package});

  final Package? package;

  @override
  Widget build(BuildContext context) {
    final isFirstTimer =
        package?.name?.toLowerCase().contains('first') ?? false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            package?.name ?? '',
            style: DDinExp.extraBold.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              PackageDuration(
                duration: package?.expiry.toString(),
              ),
              const SizedBox(
                width: 10,
              ),
              MyCredit(
                credit: isFirstTimer
                    ? package?.price?.formatIDR()
                    : package?.price.toString(),
                fontSize: 14,
                isPackageDetail: isFirstTimer ? false : true,
                iconSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ],
          )
        ],
      ),
    );
  }
}
