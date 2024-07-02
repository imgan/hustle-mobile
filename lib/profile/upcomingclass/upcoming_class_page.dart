import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/book/class/status_book.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/arg_recovery_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/profile/upcomingclass/widget/upcoming_class_item.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../pages/book/class/detail/class_detail_page.dart';
import '../../pages/book/recovery/detail/recovery_detail_page.dart';
import '../../pages/book/trainer/detail/trainer_detail.dart';
import '../profile_controller.dart';

class UpcomingClassPage extends StatefulWidget {
  const UpcomingClassPage({Key? key}) : super(key: key);

  @override
  State<UpcomingClassPage> createState() => _UpcomingClassPageState();
}

class _UpcomingClassPageState extends State<UpcomingClassPage> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final bool isClass = controller.upcomingClass.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Upcoming Classes',
      ),
      body: GetBuilder<ProfileController>(builder: (context) {
        return SingleChildScrollView(
          child: isClass
              ? Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.upcomingClass.length,
                      itemBuilder: (context, index) {
                        final upcomingClass = controller.upcomingClass[index];
                        final sessionId =
                            controller.upcomingClass[index].sessionId;
                        final memberId = controller.upcomingClass[index].id;
                        return UpcomingClassItem(
                          upcomingClass: upcomingClass,
                          onTap: () {
                            switch (upcomingClass.session?.category) {
                              case 'class':
                                Get.to(() => ClassDetailPage(), arguments: {
                                  ArgumentClassDetail.statusBook:
                                      StatusBook.booked,
                                  ArgumentClassDetail.scheduleId: sessionId,
                                  ArgumentClassDetail.memberSessionId: memberId,
                                  ArgumentClassDetail.sportsClassId:
                                      upcomingClass.session?.sportsClassId
                                });
                                break;
                              case 'recovery':
                                Get.to(
                                    () => RecoveryDetailPage(
                                          title: 'Recovery',
                                        ),
                                    arguments: {
                                      ArgRecoveryDetail.sessionId: sessionId,
                                      ArgRecoveryDetail.sportClassId:
                                          upcomingClass.session?.sportsClassId,
                                      ArgRecoveryDetail.isCancel: true,
                                      ArgRecoveryDetail.memberSessionId:
                                          memberId,
                                      ArgRecoveryDetail.title: 'Recovery',
                                    });
                                break;
                              case 'wellness':
                                Get.to(
                                    () => RecoveryDetailPage(
                                          title: 'Wellness',
                                        ),
                                    arguments: {
                                      ArgRecoveryDetail.sessionId: sessionId,
                                      ArgRecoveryDetail.sportClassId:
                                          upcomingClass.session?.sportsClassId,
                                      ArgRecoveryDetail.isCancel: true,
                                      ArgRecoveryDetail.memberSessionId:
                                          memberId,
                                      ArgRecoveryDetail.title: 'Wellness',
                                    });
                                break;
                              case 'personal trainer':
                                Get.to(() => TrainerDetail(), arguments: {
                                  ArgTrainerDetail.teacherId:
                                      upcomingClass.session?.teacherId,
                                  ArgTrainerDetail.isCancel: true,
                                  ArgTrainerDetail.memberSessionId: memberId
                                });
                                break;
                              default:
                                if (kDebugMode) {
                                  print('Invalid category');
                                }
                            }
                          },
                        );
                      },
                    )
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Get.height / 3.5),
                  width: Get.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_no_class.svg",
                          height: 119,
                          width: 161.92,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'You haven’t booked any classes yet!',
                          textAlign: TextAlign.center,
                          style: DDinExp.regular.copyWith(
                            color: gray2,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
