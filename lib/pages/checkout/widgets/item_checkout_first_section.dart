import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../model/package_first_timer.dart';
import '../../../utils/extension/int.dart';
import '../../../utils/extension/string.dart';

class ItemCheckoutFirstSection extends StatelessWidget {
  const ItemCheckoutFirstSection({super.key, this.package});

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
          Text(
            package?.name ?? '',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  description?.replaceFirst(' ', '') ?? '',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                package?.price?.formatIDR() ?? '0',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text.rich(TextSpan(children: [
            WidgetSpan(
              child: SvgPicture.asset(
                "assets/images/ic_clock_outline.svg",
              ),
            ),
            TextSpan(
              text: " Expired in: ${package?.expiry} Days",
            ),
          ])),
        ],
      ),
    );
  }
}
