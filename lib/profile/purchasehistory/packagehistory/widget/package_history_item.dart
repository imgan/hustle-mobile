import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:intl/intl.dart';

import '../../../../model/package_history.dart';
import '../../../../utils/colors.dart';

class PackageHistoryItem extends StatelessWidget {
  PackageHistoryItem({
    super.key,
    required this.onTap,
    this.packageHistory,
  });

  final VoidCallback onTap;
  final PackageHistory? packageHistory;

  @override
  Widget build(BuildContext context) {
    String? expired = DateFormat('dd MMM yyyy')
        .format(packageHistory!.expired ?? DateTime(2000));
    return Container(
      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 1, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1, color: disableColor),
            top: BorderSide(width: 1, color: disableColor),
            right: BorderSide(width: 1, color: disableColor),
            bottom: BorderSide(width: 1, color: disableColor),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${packageHistory?.package ?? ''} ",
                        style: DDinExp.semiBold.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        convertHtmlToText(packageHistory?.description ?? ''),
                        style: DDinExp.regular.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: SvgPicture.asset(
                              'assets/images/ic_clock_outline.svg',
                              height: 14,
                              width: 14,
                              colorFilter:
                                  ColorFilter.mode(gray, BlendMode.srcIn),
                            )),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            TextSpan(
                              text: "Valid until: $expired",
                              style: DDinExp.regular.copyWith(
                                color: gray,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    packageHistory?.transactionDate
                            ?.formatDate(format: 'dd MMM yyyy') ??
                        '',
                    style: DDinExp.regular.copyWith(
                      color: gray,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: disableColor, thickness: 1),
          Container(
            alignment: Alignment.center,
            height: 30,
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 7, top: 1),
            child: InkWell(
              onTap: onTap,
              child: Text(
                'View Details',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final RegExp htmlEntities = RegExp(r'&[^;]*;');

  String convertHtmlToText(String html) {
    String text = html.replaceAll(RegExp(r'<[^>]*>'), '');

    text = text.replaceAll(htmlEntities, '');

    return text;
  }
}
