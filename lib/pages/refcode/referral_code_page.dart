import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/refcode/referral_controller.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/header_referral_section.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/how_to_referral_section.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/referral_code_section.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/referral_used_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

class ReferralCodePage extends StatelessWidget {
  ReferralCodePage({super.key});

  final controller = Get.put(ReferralController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Referral Code',
        isNoDivider: true,
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ReferralController>(builder: (_) {
        final String refCode = controller.referralCode.value?.data ?? '';
        return SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  const HeaderReferralSection(),
                  ReferralCodeSection(refCode: refCode),
                  const HowToReferralSection(),
                  ReferralUsedSection(
                    referrers: controller.referralList,
                    isShowMore: controller.isShowMore.value,
                    onTap: () {
                      controller.updateShowMore();
                    },
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
