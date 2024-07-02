import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_controller.dart';
import 'package:intl/intl.dart';

import '../../../model/checkout_book.dart';
import '../../../model/class_detail.dart';
import '../../../model/schedule.dart';
import '../../../profile/profile_controller.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../../utils/my_pref.dart';
import '../../../utils/widgets/custom_dialog.dart';
import '../../../utils/widgets/error/error_book.dart';
import '../../book/checkout/checkout_book_controller.dart';
import '../../book/checkout/checkout_bottom_sheet.dart';
import '../../book/class/book_class_controller.dart';
import '../../home/home_controller.dart';

class ClassScheduleController extends GetxController {
  var arguments = Get.arguments;
  final dates = List<DateTime>.generate(
      30,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));

  Rxn<SportClass> sportClass = Rxn();
  Rxn<CheckOutBook> checkOutBook = Rxn();
  RxString month = DateFormat('MMMM yyyy').format(DateTime.now()).obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingCredit = false.obs;
  RxList<Schedule> schedules = RxList();
  Rxn<ClassDetail> classDetail = Rxn();
  RxInt total = 0.obs;
  RxString codeVoucher = ''.obs;

  final RestApiController restApiController = Get.find<RestApiController>();
  late LocationController locationController;

  @override
  void onInit() {
    if (arguments is SportClass) {
      sportClass.value = arguments;
    }
    locationController = Get.put(LocationController(onApplyFilter: () {
      getSchedules();
    }));
    locationController.resetFilter();
    getSchedules();
    super.onInit();
  }

  Future<void> getSchedules() async {
    var selectedDate =
        DateFormat('yyyy-MM-dd').format(dates[currentIndex.value]);
    isLoading.value = true;
    update();
    try {
      final queryParameter = {
        'date': selectedDate,
        'class_id': sportClass.value?.id,
        'location_id': locationController.locationSelected.join(','),
      };
      var response = await restApiController.get(
          endpoint: Endpoint.schedule, queryParameters: queryParameter);
      schedules.value = List<Schedule>.from(
          response.data["data"].map((x) => Schedule.fromJson(x)));
      getPriceActiveSubscribe();
      codeVoucher.value = '';
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error schedules ${e.message}');
    }
  }

  Future<int> sessionSubTotal(String id) async {
    try {
      final parameter = {"sessionID": id.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      update();
      if (response?.statusCode == 200) {
        total.value = response?.data['data']['total'];
        return response?.data['data']['total'];
      }
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
    return 0;
  }

  Future<void> sessionSubTotalWithCode({String? code}) async {
    try {
      final parameter = {"sessionID": classDetail.value?.id, "code": code};
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      total.value = response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
  }

  void getPriceActiveSubscribe() async {
    var isSubscribe = Get.find<MyPref>().isSubscribe;
    if (isSubscribe.val) {
      isLoadingCredit.value = true;
      for (int i = 0; i < schedules.length; i++) {
        var schedule = schedules[i];
        schedules[i].price = await sessionSubTotal(schedule.id.toString());
      }
      isLoadingCredit.value = false;
      update();
    }
  }

  void bookSchedule(int id) async {
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      final parameter = {"sessionID": id.toString(), "code": codeVoucher.value};
      var response = await restApiController.post(
          endpoint: Endpoint.scheduleBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.dialog(CustomDialog().success('You\'re All Set!', () {
          Get.back();
          Get.back();
        }));
        updateSchedules();
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

  void getScheduleDetail(int id) async {
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      Get.back();
      var response = await restApiController.get(
          endpoint: '${Endpoint.scheduleDetail}/$id');
      classDetail.value = ClassDetail.fromJson(response.data['data']);
      await sessionSubTotalWithCode();
      Get.bottomSheet(
        CheckoutBottomSheet(
          isClass: true,
          route: Get.currentRoute,
          category: 'class',
          locationID: classDetail.value?.locationId,
          onTap: () {
            bookSchedule(id);
          },
        ),
        ignoreSafeArea: false,
        isScrollControlled: true,
      ).whenComplete(() {
        Get.delete<CheckoutBookController>();
      });
      update();
    } on DioException catch (e) {
      Get.back();
      update();
      log('error detail class ${e.message}');
    }
  }

  void notifySchedule(int id, int index) async {
    try {
      final parameter = {"sessionID": id.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.notifyMe, data: parameter);
      schedules[index].status = changeStatus(index);
      if (response?.data['status'] == false) {
        errorBook('Notify Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error notify class ${e.message}');
    }
  }

  String changeStatus(int index) {
    if (schedules[index].notifyMe != null) {
      schedules[index].notifyMe = null;
      return "Fully Booked";
    }
    if (schedules[index].status == "Waiting") {
      return "Fully Booked";
    }
    return "Waiting";
  }

  void initCheckOutBook() {
    var myCredit = Get.find<MyPref>().myCredit;
    checkOutBook.value = CheckOutBook(
        credit: myCredit.val,
        image: classDetail.value?.sportsClass?.sportsClassAsset?.logoUrl ?? '',
        name: classDetail.value?.sportsClass?.name ?? '',
        hour: classDetail.value?.getHour() ?? '',
        date: classDetail.value?.getDate() ?? '',
        total: total.value.toString(),
        location: classDetail.value?.location?.locationName ?? '',
        trainer:
            '${classDetail.value?.teacher?.firstName} ${classDetail.value?.teacher?.lastName}',
        voucher: codeVoucher.value);
    update();
  }

  void updateMonth(String value) {
    month.value = value;
    update();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }

  void updateCodeVoucher(String value) {
    codeVoucher.value = value;
    initCheckOutBook();
    update();
  }

  void updateSchedules() {
    Get.find<BookClassController>().getSchedules();
    getSchedules();
  }

  void updateProfiles() {
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().getUpcomingClass();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
  }
}
