import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemSearchRecent extends StatelessWidget {
  const ItemSearchRecent({super.key, required this.recent, this.onTap});

  final String recent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_purchase_history.svg",
              colorFilter: ColorFilter.mode(gray2, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            Text(
              recent,
              textAlign: TextAlign.center,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
