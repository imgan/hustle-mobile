import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/package_first_timer.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/extension/int.dart';
import '../../../utils/extension/string.dart';

class ItemCheckoutSection extends StatelessWidget {
  const ItemCheckoutSection({super.key, required this.package});

  final Package? package;

  @override
  Widget build(BuildContext context) {
    var description = (package?.description?.contains('<br>') ?? false)
        ? package?.description?.removeAllHtmlTags().split(',').join() ?? ''
        : package?.description;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                package?.name ?? '',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                '${package?.price} Credits',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Valid for ${package?.expiry?.parseMonth()} Month',
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description ?? '',
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
