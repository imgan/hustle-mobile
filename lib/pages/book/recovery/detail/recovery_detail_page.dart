import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class_detail.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/arg_recovery_detail.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/recovery_detail_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/widgets/button_recovery_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/image/image_cover.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_detail.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_bold.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_description.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/detail/cancelled_label_detail_section.dart';
import '../../../../utils/widgets/detail/expandable_detail_section.dart';
import '../../../../utils/widgets/detail/location_detail_section.dart';
import '../../../../utils/widgets/detail/rating_detail_section.dart';
import '../../../../utils/widgets/detail/title_detail_section.dart';
import '../../../../utils/widgets/review_section.dart';

class RecoveryDetailPage extends StatelessWidget {
  final String? title;

  RecoveryDetailPage({
    super.key,
    this.title,
  });

  final RecoveryDetailController controller =
      Get.put(RecoveryDetailController());

  @override
  Widget build(BuildContext context) {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '$title Details',
      ),
      body: GetBuilder<RecoveryDetailController>(builder: (context) {
        switch (controller.recoveryState.value) {
          case LoadingState():
            return const LoadingDetail();
          case ErrorState(error: var err):
            return Text(err ?? '');
          case SuccessState<ClassDetail>(result: var res):
            var classDetail = res;
            var sportClass = classDetail?.sportsClass;
            final review = controller.review.value;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCover(url: sportClass?.imageUrl ?? ''),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleDetailSection(
                                  title: sportClass?.name ?? '',
                                  isShowCredit: controller.isShowCredit(),
                                  isShowDisablePoint: controller.isShowDetail(),
                                  price: classDetail?.price.toString() ?? '',
                                  rewardPoint: sportClass?.rewardPoints ?? 0,
                                  isShowPoint: !controller.isCancelled()),
                              RatingDetailSection(
                                  isVisible: (review?.totalRatings ?? 0) > 0,
                                  averageRating: review?.averageRating ?? 0.0,
                                  totalRating: review?.totalRatings ?? 0),
                              const SizedBox(
                                height: 16,
                              ),
                              LocationDetailSection(
                                  duration: sportClass?.duration ?? 0,
                                  location:
                                      classDetail?.location?.locationName ??
                                          ''),
                              Visibility(
                                visible: controller.isShowDetail(),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: TextBold(
                                    text: res?.getDateSchedule() ?? '',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextDescription(
                                  description: sportClass?.description ?? '')
                            ],
                          ),
                        ),
                        CancelledLabelDetailSection(
                            isVisible: controller.isCancelled()),
                        Visibility(
                          visible: !controller.isCancelled() &&
                              !isFromBookingHistory,
                          child: Column(
                            children: [
                              Divider(
                                color: gray1,
                                thickness: 1,
                              ),
                              ExpandableDetailSection(
                                isVisible: !isFromBookingHistory,
                                title: 'Cancellation policy',
                                description:
                                    sportClass?.cancellationPolicy ?? '',
                                isExpand: controller.isExpandCancellation.value,
                                onTap: () {
                                  controller.updateExpandCancellation();
                                },
                              ),
                              ExpandableDetailSection(
                                isVisible: !isFromBookingHistory,
                                title: 'How to prepare',
                                description: sportClass?.prepare ?? '',
                                isExpand: controller.isExpandPrepare.value,
                                onTap: () {
                                  controller.updateExpandPrepare();
                                },
                              ),
                              ReviewSection(
                                isVisible: controller.comments.isNotEmpty &&
                                    !controller.isCancelled(),
                                review: controller.review.value,
                                comment: controller.comments.isNotEmpty
                                    ? controller.comments[0]
                                    : null,
                                id: controller
                                    .arguments[ArgRecoveryDetail.sportClassId]
                                    .toString(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                ButtonRecoverySection(
                  title: title ?? '',
                  name: sportClass?.name ?? '',
                  recovery: res,
                )
              ],
            );

          default:
            return const SizedBox();
        }
      }),
    );
  }
}
