import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

import '../../../utils/colors.dart';
import '../../utils/widgets/custom_web_view.dart';
import 'membershipcard_controller.dart';

class MembershipCardPage extends StatelessWidget {
  MembershipCardPage({super.key});

  final membershipCardController = Get.put(MembershipCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Proof of Hustlers',
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<MembershipCardController>(builder: (_) {
        if (membershipCardController.isLoading.isTrue) {
          return const Loading(
            height: 225,
          );
        }
        if (membershipCardController.isActive.value == 0) {
          Get.find<ProfileController>().getUserProfile();
          Get.back();
          return Container();
        }
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                    image: const AssetImage(
                      "assets/images/bg_new_membership.png",
                    ),
                    height: 225,
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_logo.svg",
                          height: 22,
                          width: 22,
                          colorFilter:
                              ColorFilter.mode(primaryColor, BlendMode.srcIn),
                        ),
                        SvgPicture.asset(
                          "assets/images/ic_proof_of_hustle.svg",
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                membershipCardController.name.value,
                                style: DDinExp.bold.copyWith(
                                    color: primaryColor, fontSize: 31),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                membershipCardController
                                    .membershipCodeData.value,
                                style: DDinExp.regular.copyWith(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text(
                                'EXP',
                                style: DDinExp.bold
                                    .copyWith(color: Colors.white, fontSize: 9),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              Text(
                                membershipCardController.expiredDate.value
                                        .formatDate(format: "dd MMM yyyy") ??
                                    '',
                                style: DDinExp.bold
                                    .copyWith(color: Colors.white, fontSize: 9),
                              ),
                              const SizedBox(
                                width: 66,
                              ),
                            ],
                          )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                membershipCardController.termConditionData[0].title1,
                style: DDinExp.black.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  membershipCardController.initWebView();
                  Get.to(() => CustomWebView(
                      title: 'Proof of Hustlers',
                      webViewController:
                          membershipCardController.webViewController));
                },
                child: AbsorbPointer(
                  child: HtmlWidget(membershipCardController
                      .termConditionData[0].description1),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
