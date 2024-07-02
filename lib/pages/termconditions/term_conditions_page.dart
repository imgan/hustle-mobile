import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/termconditions/term_condition_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

class TermsConditionsPage extends StatelessWidget {
  TermsConditionsPage({super.key});

  final controller = Get.put(TermConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Terms & Conditions',
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<TermConditionController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                controller.termConditionData.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.termConditionData[0].title1,
                              style: DDinExp.bold.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.termConditionData[0].description1,
                              style: DDinExp.regular.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.3
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 98,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        )),
              ],
            ),
          ),
        );
      }),
    );
  }
}