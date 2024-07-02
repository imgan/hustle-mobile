import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class_detail.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/checkout/checkout_bottom_sheet.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/status_book.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/notify_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/dialog/cancel_dialog.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/cancelled_label_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/expandable_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/location_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/rating_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/title_detail_section.dart';
import 'package:hustle_house_flutter/utils/widgets/image/image_cover.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_detail.dart';
import 'package:hustle_house_flutter/utils/widgets/review_section.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_bold.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_description.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_italic.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/home_bindings.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/floating_button.dart';
import '../../../../utils/widgets/floating_button_icon.dart';
import '../../../bookingclass/class_schedule/class_schedule_page.dart';

class ClassDetailPage extends StatelessWidget {
  ClassDetailPage({super.key});

  final ClassDetailController controller = Get.put(ClassDetailController());

  @override
  Widget build(BuildContext context) {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Class Details',
      ),
      body: GetBuilder<ClassDetailController>(builder: (context) {
        switch (controller.classDetailState.value) {
          case LoadingState():
            return const LoadingDetail();
          case ErrorState(error: var err):
            return Text(err ?? '');
          case SuccessState<ClassDetail>(result: var res):
            final classDetail = res;
            final sportsClass = classDetail?.sportsClass;
            final review = controller.review.value;
            final trainer = classDetail?.teacher;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCover(url: sportsClass?.imageUrl ?? ''),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 14.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleDetailSection(
                                  title: sportsClass?.name ?? '',
                                  isShowCredit: controller.isShowCredit(),
                                  price: classDetail?.price.toString() ?? '',
                                  rewardPoint: sportsClass?.rewardPoints ?? 0,
                                  isShowPoint: controller.isNotCancelled()),
                              RatingDetailSection(
                                  isVisible: (review?.totalRatings ?? 0) > 0,
                                  averageRating: review?.averageRating ?? 0.0,
                                  totalRating: review?.totalRatings ?? 0),
                              const SizedBox(
                                height: 16,
                              ),
                              LocationDetailSection(
                                  duration: sportsClass?.duration ?? 0,
                                  location:
                                      classDetail?.location?.locationName ??
                                          ''),
                              const SizedBox(
                                height: 16,
                              ),
                              Visibility(
                                visible:
                                    trainer?.firstName?.isNotEmpty ?? false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                        text: classDetail?.getDateSchedule() ??
                                            ''),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextItalic(
                                        text:
                                            'with ${trainer?.firstName} ${trainer?.lastName}'),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                  ],
                                ),
                              ),
                              TextDescription(
                                  description: sportsClass?.description ?? '')
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.isNotCancelled(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: gray1,
                                thickness: 1.h,
                                height: 20.h,
                              ),
                              NotifyDetailSection(
                                  isVisible: controller.isNotifyOrNotified()),
                              ExpandableDetailSection(
                                isVisible: !isFromBookingHistory,
                                title: 'Cancellation policy',
                                description:
                                    sportsClass?.cancellationPolicy ?? '',
                                isExpand: controller.isExpandCancellation.value,
                                onTap: () {
                                  controller.updateExpandCancellation();
                                },
                              ),
                              ExpandableDetailSection(
                                isVisible: !isFromBookingHistory,
                                title: 'How to prepare',
                                description: sportsClass?.prepare ?? '',
                                isExpand: controller.isExpandPrepare.value,
                                onTap: () {
                                  controller.updateExpandPrepare();
                                },
                              ),
                              ReviewSection(
                                isVisible: controller.comments.isNotEmpty,
                                review: controller.review.value,
                                comment: controller.comments.isNotEmpty
                                    ? controller.comments[0]
                                    : null,
                                id: controller.arguments[
                                        ArgumentClassDetail.sportsClassId]
                                    .toString(),
                              )
                            ],
                          ),
                        ),
                        CancelledLabelDetailSection(
                            isVisible: !controller.isNotCancelled())
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      controller.isBookOrBooked() && controller.isDatePassed(),
                  child: FloatingButtonIcon(
                    text: controller.statusBook.value == StatusBook.booked
                        ? 'Cancel Booking'
                        : 'Book Class for',
                    isShowIcon: !controller.isBooked(),
                    credit: controller.total.toString(),
                    colorButton:
                        controller.isBook() ? primaryColor : Colors.white,
                    textColor: controller.isBook() ? Colors.black : red,
                    shadowColor: controller.isBook()
                        ? const Color(0x33000000)
                        : Colors.transparent,
                    borderColor: controller.statusBook.value == StatusBook.book
                        ? primaryColor
                        : red,
                    onPressed: () {
                      if (controller.isBook()) {
                        if (controller.isFromHome()) {
                          Get.to(() => ClassSchedulePage(),
                              arguments: controller
                                  .arguments[ArgumentClassDetail.classDetail],
                              binding: HomeBindings());
                        } else {
                          Get.bottomSheet(
                            CheckoutBottomSheet(
                              isClass: true,
                              route: Get.currentRoute,
                              category: 'class',
                              locationID: classDetail?.location?.id,
                              onTap: () {
                                controller.bookSchedule();
                              },
                            ),
                            ignoreSafeArea: false,
                            isScrollControlled: true,
                          );
                        }
                      } else if (controller.isBooked()) {
                        Get.dialog(CancelDialog(
                            title: 'Cancel Booking',
                            subTitle: controller.isReturnCredit.isFalse
                                ? 'Are you sure you want to cancel this booking?'
                                : 'Are you sure you want to cancel this booking? Your credits will be returned.',
                            message: controller.isReturnCredit.isFalse
                                ? 'Your credits will not be returned'
                                : '',
                            onTap: () {
                              controller.cancelBook();
                            }));
                      }
                    },
                  ),
                ),
                if (controller.isNotCancelled())
                  Visibility(
                    visible: isFromBookingHistory &&
                        controller.arguments.length > 4 &&
                        controller
                                .arguments[ArgumentClassDetail.isUserComment] ==
                            false,
                    child: FloatingButton(
                      text: "Rate Class",
                      onPressed: () {
                        Get.dialog(CustomDialog().rating(rate: (rate, comment) {
                          controller.reviewClass(
                              rate: '$rate', comment: comment);
                        }));
                      },
                    ),
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
