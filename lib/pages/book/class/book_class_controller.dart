import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/location.dart';
import 'package:intl/intl.dart';

import '../../../model/class.dart';
import '../../../model/schedule.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../../utils/my_pref.dart';
import '../../../utils/widgets/error/error_book.dart';

class BookClassController extends GetxController {
  final dates = List<DateTime>.generate(
      30,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));

  RxInt currentIndex = 0.obs;
  RxInt totalFilter = 0.obs;
  RxString month = DateFormat('MMMM yyyy').format(DateTime.now()).obs;
  RxBool isPopUpLocations = false.obs;
  RxBool isPopUpClass = false.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingCredit = false.obs;
  RxBool isLoadingMonthPackage = true.obs;
  RxList<int> locationSelected = RxList();
  RxList<int> classSelected = RxList();
  RxList<Schedule> schedules = RxList();
  RxList<SportClass> classes = RxList();
  RxList<SportClass> allClass = RxList();
  RxList<Location> locations = RxList();
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxBool isShowCancel = false.obs;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getSchedules();
    getClasses();
    getLocations();
    getPackage();
    super.onInit();
  }

  void getSchedules() async {
    var selectedDate =
        DateFormat('yyyy-MM-dd').format(dates[currentIndex.value]);
    isLoading.value = true;
    update();
    try {
      final queryParameter = {
        'date': selectedDate,
        'location_id': locationSelected.join(','),
        'class_id': classSelected.join(','),
        'category': 'class'
      };
      var response = await restApiController.get(
          endpoint: Endpoint.schedule, queryParameters: queryParameter);
      schedules.value = List<Schedule>.from(
              response.data["data"].map((x) => Schedule.fromJson(x)))
          .where((element) => element.sportsClass?.category == 'class')
          .toList();
      getPriceActiveSubscribe();
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error schedules ${e.message}');
    }
  }

  void getClasses() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.sportsClass);
      classes.value = List<SportClass>.from(
              response.data["data"].map((x) => SportClass.fromJson(x)))
          .where((element) => element.category == 'class')
          .toList();
      allClass.value = List<SportClass>.from(
              response.data["data"].map((x) => SportClass.fromJson(x)))
          .where((element) => element.category == 'class')
          .toList();
      update();
    } on DioException catch (e) {
      log('error classes ${e.message}');
    }
  }

  void getLocations() async {
    try {
      var response = await restApiController.get(endpoint: Endpoint.location);
      locations.value = List<Location>.from(
          response.data["data"].map((x) => Location.fromJson(x)));
      update();
    } on DioException catch (e) {
      log('error location ${e.message}');
    }
  }

  void getPackage() async {
    isLoadingMonthPackage.value = true;
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.package);
      isLoadingMonthPackage.value = false;
      title.value = response?.data['data']['month_class_package']['title'];
      description.value =
          response?.data['data']['month_class_package']['description'];
      update();
    } on DioException catch (e) {
      isLoadingMonthPackage.value = false;
      update();
      log('error package ${e.message}');
    }
  }

  Future<int> sessionSubTotal(String id) async {
    try {
      final parameter = {"sessionID": id.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      update();
      if (response?.statusCode == 200) {
        return response?.data['data']['total'];
      }
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
    return 0;
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

  void updateTotalFilter() {
    totalFilter.value = locationSelected.length + classSelected.length;
    update();
  }

  void updateFilter() {
    updateTotalFilter();
    getSchedules();
    update();
  }

  void updateLocationSelected(int id, bool isAdd) {
    if (isAdd) {
      locationSelected.add(id);
    } else {
      locationSelected.remove(id);
    }
    update();
  }

  void updateClassSelected(int id, bool isAdd) {
    if (isAdd) {
      classSelected.add(id);
    } else {
      classSelected.remove(id);
    }
    update();
  }

  void updatePopUpLocations() {
    isPopUpLocations.value = !isPopUpLocations.value;
    update();
  }

  void updatePopUpClass({bool? value}) {
    isPopUpClass.value = value ?? !isPopUpClass.value;
    update();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }

  void updateMonth(String value) {
    month.value = value;
    update();
  }

  void updateShowCancel(bool value) {
    isShowCancel.value = value;
    update();
  }

  void onFilterClass(String value) {
    classes.clear();
    for (SportClass sportClass in allClass) {
      if (sportClass.name?.contains(value) ?? false) {
        classes.add(sportClass);
      }
    }
    update();
  }

  void updateClasses() {
    classes.clear();
    classes.addAll(allClass);
    update();
  }

  void resetFilter() {
    locationSelected.value = RxList();
    classSelected.value = RxList();
    isPopUpLocations.value = false;
    isPopUpClass.value = false;
    updateTotalFilter();
    update();
  }

  Future<void> refreshClass() async {
    getSchedules();
    getClasses();
    getLocations();
    getPackage();
  }
}
