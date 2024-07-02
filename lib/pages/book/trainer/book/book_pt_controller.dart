import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:intl/intl.dart';

import '../../../../model/checkout_book.dart';
import '../../../../model/class_detail.dart';
import '../../../../model/schedule_time.dart';
import '../../../../profile/profile_controller.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/my_pref.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/error/error_book.dart';
import '../../checkout/checkout_book_controller.dart';
import '../../checkout/checkout_bottom_sheet.dart';
import '../../class/status_book.dart';

class BookPTController extends GetxController {
  final dates = List<DateTime>.generate(
      30,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));

  RxList<ScheduleTime> scheduleTimes = RxList();
  Rxn<ClassDetail> classDetail = Rxn();
  Rx<Result> scheduleTimeState = Rx(LoadingState());

  RxString month = DateFormat('MMMM yyyy').format(DateTime.now()).obs;
  RxInt currentDateIndex = 0.obs;
  RxInt currentScheduleId = 0.obs;
  RxInt currentMemberSessionId = 0.obs;
  RxInt total = 0.obs;
  RxBool isLoadingNotify = false.obs;
  RxBool isCanBook = false.obs;
  RxBool isReturnCredit = false.obs;
  Rx<StatusBook> statusBook = StatusBook.book.obs;
  var arguments = Get.arguments;
  RxString codeVoucher = ''.obs;
  Rxn<CheckOutBook> checkOutBook = Rxn();

  final RestApiController restApiController = Get.find<RestApiController>();
  var myCredit = Get.find<MyPref>().myCredit;

  @override
  void onInit() {
    getSchedules();
    super.onInit();
  }

  void getSchedules() async {
    final teacherId = arguments[0].toString();
    var selectedDate =
        DateFormat('yyyy-MM-dd').format(dates[currentDateIndex.value]);
    scheduleTimeState.value = LoadingState();
    currentScheduleId.value = 0;
    currentMemberSessionId.value = 0;
    isCanBook.value = false;
    update();
    try {
      final queryParameter = {'date': selectedDate, 'teacher_id': teacherId};
      var response = await restApiController.get(
          endpoint: Endpoint.selectedTimeTeacher,
          queryParameters: queryParameter);
      scheduleTimes.value = List<ScheduleTime>.from(
          response.data["data"].map((x) => ScheduleTime.fromJson(x)));
      currentScheduleId.value =
          scheduleTimes.isNotEmpty ? scheduleTimes[0].id ?? 0 : 0;
      currentMemberSessionId.value = scheduleTimes.isNotEmpty
          ? scheduleTimes[0].memberSession?.id ?? 0
          : 0;
      if (scheduleTimes.isEmpty) {
        scheduleTimeState.value = EmptyState();
      } else {
        scheduleTimeState.value = SuccessState<List<ScheduleTime>>(scheduleTimes);
      }
      sessionSubTotal();
      checkStatusBook();
      checkStatusCancel();
      update();
    } on DioException catch (e) {
      scheduleTimeState.value = ErrorState(e.message);
      isCanBook.value = false;
      checkStatusBook();
      update();
      log('error schedules ${e.message}');
    }
  }

  void getBook() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      var response = await restApiController.get(
          endpoint: '${Endpoint.scheduleDetail}/${currentScheduleId.value}');
      if (response?.statusCode == 200) {
        Get.back();
        classDetail.value = ClassDetail.fromJson(response?.data['data']);
        Get.bottomSheet(
          CheckoutBottomSheet(
            isClass: false,
            route: Get.currentRoute,
            category: 'personal trainer pt',
            locationID: classDetail.value?.location?.id,
            onTap: () {
              bookSchedule();
            },
          ),
          ignoreSafeArea: false,
          isScrollControlled: true,
        ).whenComplete(() {
          Get.delete<CheckoutBookController>();
        });
      }
      update();
    } on DioException catch (e) {
      Get.back();
      update();
      log('error book pt ${e.message}');
    }
  }

  void bookSchedule() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {
        "sessionID": currentScheduleId.value.toString(),
        "code": codeVoucher.value
      };
      var response = await restApiController.post(
          endpoint: Endpoint.scheduleBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.dialog(CustomDialog().success('You\'re All Set!', () {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        }));
        updateProfiles();
        update();
      } else {
        Get.back();
        errorBook('Booking Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error book pt ${e.message}');
    }
  }

  Future<void> sessionSubTotal({String? code}) async {
    try {
      final parameter = {
        "sessionID": currentScheduleId.value.toString(),
        "code": code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      if (response?.statusCode == 200) {
        total.value = response?.data['data']['total'];
        isCanBook.value = currentScheduleId.value != 0;
      } else {
        isCanBook.value = false;
      }
      update();
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
  }

  void cancelBook() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {"memberSessionID": currentMemberSessionId.value};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.back();
        Get.dialog(CustomDialog().success('Booking Cancelled', () {
          Get.back();
        }));
        Get.find<ProfileController>().getBookingHistory();
        updateProfiles();
        statusBook.value = changeStatusBook(statusBook.value);
        update();
      } else {
        Get.back();
        errorBook('Cancel Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error cancel class ${e.message}');
    }
  }

  void checkStatusCancel() async {
    if (statusBook.value == StatusBook.booked) {
      try {
        final parameter = {"memberSessionID": currentMemberSessionId.value};
        var response = await restApiController.get(
            endpoint: Endpoint.checkStatusCancel, queryParameters: parameter);
        isReturnCredit.value = (response?.data['status']
                    .toString()
                    .toLowerCase()
                    .contains('not') ??
                false)
            ? true
            : false;
        update();
      } on DioException catch (e) {
        update();
        log('error status cancel ${e.message}');
      }
    }
  }

  void notifySchedule() async {
    isLoadingNotify.value = true;
    update();
    try {
      final parameter = {"sessionID": currentScheduleId.value.toString()};
      await restApiController.post(
          endpoint: Endpoint.notifyMe, data: parameter);
      isLoadingNotify.value = false;
      update();
    } on DioException catch (e) {
      isLoadingNotify.value = false;
      update();
      log('error book pt ${e.message}');
    }
  }

  void updateDateIndex(int index) {
    currentDateIndex.value = index;
    update();
  }

  void updateScheduleId(int id) {
    currentScheduleId.value = id;
    update();
  }

  void updateMemberSessionId(int id) {
    currentMemberSessionId.value = id;
    checkStatusCancel();
    update();
  }

  void updateMonth(String value) {
    month.value = value;
    update();
  }

  void updateCodeVoucher(String value) {
    codeVoucher.value = value;
    initCheckOutBook();
    update();
  }

  void checkStatusBook({int index = 0}) {
    if (scheduleTimes.isNotEmpty) {
      String? notify = scheduleTimes[index].notifyMe != null ? 'waiting' : null;
      statusBook.value =
          getStatusBook(notify ?? scheduleTimes[index].status ?? '');
    } else {
      statusBook.value = StatusBook.book;
    }
    update();
  }

  bool isNotify() {
    return statusBook.value == StatusBook.notify;
  }

  bool isShowNotify() {
    return statusBook.value == StatusBook.notified ||
        statusBook.value == StatusBook.notify;
  }

  bool isBooked() {
    return statusBook.value == StatusBook.booked;
  }

  void updateNotify() {
    notifySchedule();
    if (statusBook.value == StatusBook.notify) {
      statusBook.value = StatusBook.notified;
    } else if (statusBook.value == StatusBook.notified) {
      statusBook.value = StatusBook.notify;
    }
    update();
  }

  void initCheckOutBook() {
    final teacher = classDetail.value?.teacher;
    checkOutBook.value = CheckOutBook(
        credit: myCredit.val,
        image: teacher?.imageUrl ?? '',
        name: '${teacher?.firstName} ${teacher?.lastName}',
        hour: classDetail.value?.getHour() ?? '',
        date: classDetail.value?.getDate() ?? '',
        total: total.value.toString(),
        voucher: codeVoucher.value);
    update();
  }

  void updateProfiles() {
    Get.find<ProfileController>().getUpcomingClass();
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
  }
}
