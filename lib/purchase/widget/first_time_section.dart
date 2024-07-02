import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../model/package_first_timer.dart';
import '../../utils/colors.dart';
import '../../utils/extension/int.dart';
import '../../utils/widgets/loading/loading.dart';
import '../../utils/widgets/primary_button.dart';
import 'expanded_text_widget.dart';

class FirstTimeSection extends StatelessWidget {
  FirstTimeSection({super.key});

  final controller = Get.find<CreditController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreditController>(builder: (_) {
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          child: Loading(
            height: 145.h,
          ),
        );
      }
      Package? firstTime;
      if (controller.packageFirstTimer.isNotEmpty) {
        firstTime = controller.packageFirstTimer[0];
      }
      return Visibility(
        visible: firstTime?.firstTimeOnly == 1,
        child: Container(
          margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
            border: Border(
              left: BorderSide(color: disableColor),
              top: BorderSide(width: 1, color: disableColor),
              right: BorderSide(color: disableColor),
              bottom: BorderSide(width: 1, color: disableColor),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "BEST CHOICE FOR YOU",
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.all(15.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(firstTime?.name ?? '',
                          style: DDinExp.bold.copyWith(
                            color: Colors.black,
                            fontSize: 20.sp,
                          )),
                      const Spacer(),
                      Text(
                        firstTime?.price?.formatIDR() ?? '',
                        style: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                        child: SvgPicture.asset(
                          "assets/images/ic_clock_outline.svg",
                          width: 14.w,
                          height: 14.h,
                        ),
                      ),
                      TextSpan(
                        text: " Expired in: ${firstTime?.expiry} Days",
                        style: DDinExp.regular.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp
                        )
                      ),
                    ])),
                     SizedBox(
                      height: 10.h,
                    ),
                    ExpandedTextWidget(
                      text: "See details ",
                      fontSize: 14.sp,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            final description = controller.descriptions[index];
                            return Text(
                              description,
                              style: DDinExp.regular.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            );
                          },
                          itemCount: controller.descriptions.length,
                          shrinkWrap: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buttonFirstTime(firstTime?.id.toString() ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buttonFirstTime(String id) {
    if (controller.isLoadingFirstTime.isTrue) {
      return Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }
    return PrimaryButton(
      text: "Buy Package",
      elevation: 0,
      onPressed: () {
        controller.orderFirstTime(id);
      },
    );
  }
}
