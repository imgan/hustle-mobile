import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/typography/d_din_exp.dart';

class HeaderReferralSection extends StatelessWidget {
  const HeaderReferralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 41, bottom: 20),
      width: double.infinity,
      color: bgReferralColor,
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/ilus.svg',
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Refer now & earn credits!',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
