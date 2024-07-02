import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/book/checkout/checkout_book_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/argument_book_recovery.dart';
import 'package:intl/intl.dart';

import '../../../../model/checkout_book.dart';
import '../../../../model/class_detail.dart';
import '../../../../model/schedule_time.dart';
import '../../../../profile/profile_controller.dart';
import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/extension/string.dart';
import '../../../../utils/my_pref.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/error/error_book.dart';
import '../../../home/home_controller.dart';
import '../../checkout/checkout_bottom_sheet.dart';
import '../../class/status_book.dart';

class BookRecoveryController extends GetxController {
  final dates = List<DateTime>.generate(
      30,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));

  var arguments = Get.arguments;
  RxString month = DateFormat('MMMM yyyy').format(DateTime.now()).obs;
  RxInt currentDateIndex = 0.obs;
  RxInt currentSessionIndex = 0.obs;
  RxInt currentTimeId = 0.obs;
  RxInt currentMemberSessionId = 0.obs;
  RxInt total = 0.obs;
  RxString currentKey = ''.obs;
  RxString currentTime = ''.obs;
  RxBool isShowSession = false.obs;
  RxBool isShowTime = false.obs;
  RxBool isLoadingNotify = false.obs;
  RxBool isCanBook = false.obs;
  RxBool isReturnCredit = false.obs;
  RxString codeVoucher = ''.obs;
  RxList<ScheduleTime> scheduleTimes = RxList();
  Rx<Result> scheduleTimeState = Rx(LoadingState());
  Rxn<ClassDetail> classDetail = Rxn();
  Rxn<CheckOutBook> checkOutBook = Rxn();
  Rx<StatusBook> statusBook = StatusBook.book.obs;

  final RestApiController restApiController = Get.find<RestApiController>();
  var myCredit = Get.find<MyPref>().myCredit;

  @override
  void onInit() {
    getSchedules();
    total.value = arguments[ArgumentBookRecovery.price];
    super.onInit();
  }

  void getSchedules() async {
    final classId = arguments[ArgumentBookRecovery.sportClassId].toString();
    final locationId = arguments[ArgumentBookRecovery.locationId].toString();
    var selectedDate =
        DateFormat('yyyy-MM-dd').format(dates[currentDateIndex.value]);
    scheduleTimeState.value = LoadingState();
    isCanBook.value = false;
    reset();
    update();
    try {
      final queryParameter = {
        'date': selectedDate,
        'class_id': classId,
        'location_id': locationId
      };
      final endpoint = arguments[ArgumentBookRecovery.endpoint];
      var response = await restApiController.get(
          endpoint: endpoint, queryParameters: queryParameter);
      scheduleTimes.value = List<ScheduleTime>.from(
          response.data["data"].map((x) => ScheduleTime.fromJson(x)));
      initValue();
      sessionSubTotal();
      checkStatusBook();
      checkStatusCancel();
      if (scheduleTimes.isEmpty) {
        scheduleTimeState.value = EmptyState();
      } else {
        scheduleTimeState.value = SuccessState<List<ScheduleTime>>(scheduleTimes);
      }
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
          endpoint: '${Endpoint.scheduleDetail}/${currentTimeId.value}');
      if (response?.statusCode == 200) {
        Get.back();
        classDetail.value = ClassDetail.fromJson(response?.data['data']);
        Get.bottomSheet(
          CheckoutBottomSheet(
            isClass: false,
            route: Get.currentRoute,
            category:
                arguments[ArgumentBookRecovery.title].toString().toLowerCase(),
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
      log('error recovery ${e.message}');
    }
  }

  void bookSchedule() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {
        "sessionID": currentTimeId.value.toString(),
        "code": codeVoucher.value
      };
      var response = await restApiController.post(
          endpoint: Endpoint.scheduleBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.dialog(CustomDialog().success('You\'re All Set!', () {
          Get.until((route) => Get.currentRoute == '/MainPage');
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
      log('error book class ${e.message}');
    }
  }

  Future<void> sessionSubTotal({String? code}) async {
    try {
      final parameter = {
        "sessionID": currentTimeId.value.toString(),
        "code": code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      if (response?.statusCode == 200) {
        total.value = response?.data['data']['total'];
        isCanBook.value = currentTimeId.value != 0;
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
        updateProfiles();
        Get.find<ProfileController>().getBookingHistory();
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
    if (isBooked()) {
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
      final parameter = {"sessionID": currentTimeId.value.toString()};
      await restApiController.post(
          endpoint: Endpoint.notifyMe, data: parameter);
      isLoadingNotify.value = false;
      update();
    } on DioException catch (e) {
      isLoadingNotify.value = false;
      update();
      log('error book class ${e.message}');
    }
  }

  String getSessionName(String name) {
    return switch (name) {
      'morning' => 'Morning',
      'afternoon' => 'Afternoon',
      'night' => 'Evening',
      _ => ''
    };
  }

  int getSessionIndex(String name) {
    return switch (name) {
      'morning' => 0,
      'afternoon' => 1,
      'night' => 2,
      _ => 0
    };
  }

  Map<String, List<ScheduleTime>> getScheduleTimes() {
    return {
      'Morning': scheduleTimes
          .where((time) => time.category?.contains('morning') ?? false)
          .toList(),
      'Afternoon': scheduleTimes
          .where((time) => time.category?.contains('afternoon') ?? false)
          .toList(),
      'Evening': scheduleTimes
          .where((time) => time.category?.contains('night') ?? false)
          .toList(),
    };
  }

  void updateShowTime() {
    isShowTime.value = !isShowTime.value;
    update();
  }

  void updateShowSession() {
    isShowSession.value = !isShowSession.value;
    update();
  }

  void updateDateIndex(int index) {
    currentDateIndex.value = index;
    update();
  }

  void updateSessionIndex(
      String key, int index, Map<String, List<ScheduleTime>> scheduleTimes) {
    currentSessionIndex.value = index;
    currentKey.value = key;
    currentTime.value = (scheduleTimes[key]?.isNotEmpty ?? false)
        ? scheduleTimes[key]![0].startTime?.formatHour() ?? ''
        : 'Time not found';
    currentTimeId.value = (scheduleTimes[key]?.isNotEmpty ?? false)
        ? scheduleTimes[key]![0].id ?? 0
        : 0;
    currentMemberSessionId.value = (scheduleTimes[key]?.isNotEmpty ?? false)
        ? scheduleTimes[key]![0].memberSession?.id ?? 0
        : 0;
    isCanBook.value = currentTimeId.value != 0;
    update();
  }

  void updateTimeIndex(String time, int id, int memberSessionId) {
    currentTimeId.value = id;
    currentTime.value = time;
    currentMemberSessionId.value = memberSessionId;
    update();
  }

  void updateMonth(String value) {
    month.value = value;
    update();
  }

  void initValue() {
    currentTime.value = scheduleTimes.isNotEmpty
        ? scheduleTimes[0].startTime?.formatHour() ?? ''
        : '';
    currentKey.value = getSessionName(
        scheduleTimes.isNotEmpty ? scheduleTimes[0].category ?? '' : '');
    currentSessionIndex.value = getSessionIndex(
        scheduleTimes.isNotEmpty ? scheduleTimes[0].category ?? '' : '');
    currentTimeId.value =
        scheduleTimes.isNotEmpty ? scheduleTimes[0].id ?? 0 : 0;
    currentMemberSessionId.value =
        scheduleTimes.isNotEmpty ? scheduleTimes[0].memberSession?.id ?? 0 : 0;
    update();
  }

  void reset() {
    currentTimeId.value = 0;
    currentTime.value = '';
    currentKey.value = '';
    currentSessionIndex.value = 0;
    currentMemberSessionId.value = 0;
  }

  void updateCodeVoucher(String value) {
    codeVoucher.value = value;
    initCheckOutBook();
    update();
  }

  void checkStatusBook({int index = 0}) {
    if (scheduleTimes.isNotEmpty) {
      String? notify =
          getScheduleTimes()[currentKey.value]?[index].notifyMe != null
              ? 'waiting'
              : null;
      statusBook.value = getStatusBook(
          notify ?? getScheduleTimes()[currentKey.value]?[index].status ?? '');
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

  void updateNotify() {
    notifySchedule();
    if (statusBook.value == StatusBook.notify) {
      statusBook.value = StatusBook.notified;
    } else if (statusBook.value == StatusBook.notified) {
      statusBook.value = StatusBook.notify;
    }
    update();
  }

  bool isBooked() {
    return statusBook.value == StatusBook.booked;
  }

  void initCheckOutBook() {
    var sportClass = classDetail.value?.sportsClass;
    checkOutBook.value = CheckOutBook(
        credit: myCredit.val,
        image: sportClass?.sportsClassAsset?.logoUrl ?? '',
        name: sportClass?.name ?? '',
        hour: classDetail.value?.getHour() ?? '',
        date: classDetail.value?.getDate() ?? '',
        total: total.value.toString(),
        location: classDetail.value?.location?.locationName ?? '',
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
