import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/active_subscribe.dart';
import 'package:hustle_house_flutter/model/booking_history.dart';
import 'package:hustle_house_flutter/model/upcoming_class.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../model/user_profile.dart';
import '../model/voucher.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../utils/api/rest_api_controller.dart';
import '../utils/home_bindings.dart';

class ProfileController extends GetxController {
  RxBool isLoadingVoucherHistory = false.obs;
  RxBool isLoadMoreVoucher = false.obs;

  Rxn<UserProfile> userProfile = Rxn();

  RxList<Voucher> voucherHistory = RxList();
  RxList<Voucher> discountVoucher = RxList();
  RxList<Voucher> complimentaryVoucher = RxList();
  RxList<UpcomingClass> upcomingClass = RxList();
  RxList<ActiveSubscribe> activeSubscribe = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();
  RxInt totalPurchaseList = 0.obs;
  RxInt totalCreditHistory = 0.obs;
  RxInt totalBookingHistory = 0.obs;
  RxInt totalPackageHistory = 0.obs;
  RxInt totalComplimentVoucher = 0.obs;
  RxInt totalDiscountVoucher = 0.obs;
  int pageVoucher = 1;
  final int _creditValidType = 1;
  final int _voucherType = 3;
  final int _packageType = 4;
  var isActive = 0.obs;
  var flagMembership = 0.obs;
  final int _discountType = 1;
  bool isShowChangePassword = false;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getBookingHistory();
    getCreditHistory();
    getVoucherHistory();
    getPackageHistory();
    getAvailableDiscountVoucher();
    getAvailableComplimentaryVoucher();
    getUpcomingClass();
    fetchMembershipCodeFromApi();
    getActiveSubscribe();
  }

  String loginTypeIcon(String loginType) {
    switch (loginType) {
      case 'email':
        return "assets/images/ic_email.svg";
      case 'google':
        return "assets/images/ic_google.svg";
      case 'facebook':
        return "assets/images/ic_facebook_blue.svg";
      case 'apple':
        return "assets/images/ic_apple_black.svg";
      default:
        return 'invalid type';
    }
  }

  void getUserProfile() async {
    var myCredit = Get.find<MyPref>().myCredit;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.userProfile);
      userProfile.value = UserProfile.fromJson(response.data['data']);
      isShowChangePassword = userProfile.value?.loginType == 'email';
      myCredit.val =
          userProfile.value?.member?.remainingCredit.toString() ?? '0';
      update();
    } on DioException catch (e) {
      update();
      log('error user profile ${e.message}');
    }
  }

  void getBookingHistory() async {
    int completed = 0;
    int cancelled = 0;
    try {
      var responseCompleted = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCompleted,
          queryParameters: queryParameterBookingHistory(5));
      var responseCancelled = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCancelled,
          queryParameters: queryParameterBookingHistory(1));
      completed = responseCompleted?.data['data']['total'];
      cancelled = responseCancelled?.data['data']['total'];
      totalBookingHistory.value = completed + cancelled;
      var bookingHistoryCompleted = List<BookingHistory>.from(responseCompleted
          .data["data"]["data"]
          .map((x) => BookingHistory.fromJson(x)));
      Get.find<HomeController>().getCompletedBooking(bookingHistoryCompleted);
      update();
    } on DioException catch (e) {
      log('error booking history completed ${e.message}');
    }
  }

  void getCreditHistory() async {
    int valid = 0;
    try {
      var responseValid = await restApiController.get(
          endpoint: Endpoint.purchaseHistory,
          queryParameters: queryParameterPurchaseHistory(_creditValidType));
      valid = responseValid?.data['data']['total'];
      totalCreditHistory.value = valid;
      update();
    } on DioException catch (e) {
      log('error credit valid history ${e.message}');
    }
  }

  void getVoucherHistory() async {
    isLoadingVoucherHistory.value = true;
    isLoadMoreVoucher.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': 10,
        'page': pageVoucher,
        'type': _voucherType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      var vouchers = List<Voucher>.from(
          response.data["data"]["data"].map((x) => Voucher.fromJson(x)));
      voucherHistory.value = getVouchers(vouchers);
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = true;
      update();
    } on DioException catch (e) {
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = false;
      update();
      log('error voucher history ${e.message}');
    }
  }

  void getPackageHistory() async {
    try {
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory,
          queryParameters: queryParameterPurchaseHistory(_packageType));
      totalPackageHistory.value = response?.data["data"]["total"];
      update();
    } on DioException catch (e) {
      log('error package history ${e.message}');
    }
  }

  Future getAvailableDiscountVoucher() async {
    try {
      final queryParameter = {
        'type': _discountType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.availableVoucher, queryParameters: queryParameter);
      var vouchers = List<Voucher>.from(
          response.data["data"].map((x) => Voucher.fromJson(x)));
      discountVoucher.value = getVouchers(vouchers);
      totalDiscountVoucher.value = vouchers.length;
      update();
    } on DioException catch (e) {
      log('error discount voucher ${e.message}');
    }
  }

  Future getAvailableComplimentaryVoucher() async {
    try {
      final queryParameter = {
        'isExpired': 1,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.availableVoucher, queryParameters: queryParameter);
      var vouchers = List<Voucher>.from(
          response.data["data"].map((x) => Voucher.fromJson(x)));
      complimentaryVoucher.value = getVouchers(vouchers);
      totalComplimentVoucher.value = vouchers.length;
      if (Get.isRegistered<HomeController>()) {
        var responseVoucher = List<Voucher>.from(
            response.data["data"].map((x) => Voucher.fromJson(x)));
        Get.find<HomeController>().getVouchers(responseVoucher);
      }
      update();
    } on DioException catch (e) {
      log('error complimentary voucher ${e.message}');
    }
  }

  List<Voucher> getVouchers(List<Voucher> vouchers) {
    Map<String, Voucher> map = {};
    List<Voucher> result = [];
    for (final voucher in vouchers) {
      var key = voucher.code;
      if (map.containsKey(key)) {
        map[key]?.totalVoucher = (map[key]?.totalVoucher ?? 0) + 1;
      } else {
        map[key ?? ''] = voucher;
        result.add(voucher);
      }
    }
    return result;
  }

  void loadNextVoucher() async {
    isLoadingVoucherHistory.value = true;
    isLoadMoreVoucher.value = false;
    update();
    try {
      pageVoucher++;
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': 10,
        'page': pageVoucher,
        'type': _voucherType
      };

      final response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);

      if (response != null) {
        var vouchers = List<Voucher>.from(
            response.data["data"]["data"].map((x) => Voucher.fromJson(x)));
        voucherHistory.addAll(getVouchers(vouchers));
        isLoadingVoucherHistory.value = false;
        int total = response?.data['data']['total'];
        isLoadMoreVoucher.value = (voucherHistory.length) < total;
        isLoadMoreVoucher.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = false;
      log('error next page Voucher history ${e.message}');
    }
  }

  void getUpcomingClass() async {
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.upcomingClass, queryParameters: queryParameter);
      upcomingClass.value = List<UpcomingClass>.from(response.data["data"]
              ["active"]
          .map((x) => UpcomingClass.fromJson(x)));
      update();
    } on DioException catch (e) {
      log('error upcoming class ${e.message}');
    }
  }

  void deleteAccount() async {
    try {
      var parameter = {"email": userProfile.value?.email};
      var response = await restApiController.post(
          endpoint: Endpoint.deleteAccount, data: parameter);
      if (response?.statusCode == 200) {
        Get.offAll(() => OnBoardingPage(), binding: HomeBindings());
        var accessToken = Get.find<MyPref>().accessToken;
        accessToken.val = '';
      }
      update();
    } on DioException catch (e) {
      log('error deleting account ${e.message}');
    }
  }

  void fetchMembershipCodeFromApi() async {
    isActive.value = 0;
    try {
      var response = await restApiController.get(endpoint: Endpoint.memberCode);
      if (response.data['status'] == true) {
        isActive.value = response.data['data']['isActive'];
      }
      flagMembership.value = response?.data['flag'];
      update();
    } on DioException catch (e) {
      update();
      log('error fetch membershipcode data ${e.message}');
    }
  }

  void logout() async {
    try {
      var response = await restApiController.get(endpoint: Endpoint.logout);
      if (response?.statusCode == 200) {
        Get.offAll(() => LoginPage(), binding: HomeBindings());
        var accessToken = Get.find<MyPref>().accessToken;
        accessToken.val = '';
        OneSignal.logout();
      }
      update();
    } on DioException catch (e) {
      log('error logout ${e.message}');
    }
  }

  void getActiveSubscribe() {
    if (Get.isRegistered<HomeController>()) {
      activeSubscribe.value = Get.find<HomeController>().activeSubscribe;
      update();
    }
  }

  void getTotalPurchaseList() async {
    int waiting = 0;
    try {
      final queryParameterWaiting = {'page': 1, 'limit': 1, 'type': 'waiting'};
      var responseWaiting = await restApiController.get(
          endpoint: Endpoint.purchaseList,
          queryParameters: queryParameterWaiting);
      waiting = responseWaiting?.data['data']['total'];
      totalPurchaseList.value = waiting;
    } on DioException catch (e) {
      log('error purchase list ${e.message}');
    }
  }

  Map<String, int?> queryParameterPurchaseHistory(int type) {
    return {
      'memberID': userProfile.value?.id,
      'limit': 1,
      'page': 1,
      'type': type,
    };
  }

  Map<String, int?> queryParameterBookingHistory(int limit) {
    return {
      'memberID': userProfile.value?.id,
      'isFuture': 0,
      'limit': limit,
      'page': 1
    };
  }
}
