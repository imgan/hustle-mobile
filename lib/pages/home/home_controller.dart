import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart' hide Banner;
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/active_subscribe.dart';
import 'package:hustle_house_flutter/model/booking_history.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/banner.dart';
import '../../model/class.dart';
import '../../model/user_profile.dart';
import '../../model/voucher.dart';
import '../../profile/profile_controller.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/home_bindings.dart';
import '../../utils/my_pref.dart';
import '../../utils/widgets/custom_dialog.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  late WebViewController webViewController;

  var currentPage = 0.0.obs;
  Rx<Result> profileState = Rx(LoadingState());
  Rx<Result> bannerState = Rx(LoadingState());
  Rx<Result> classesState = Rx(LoadingState());
  RxBool isNewNotification = false.obs;
  RxList<ActiveSubscribe> activeSubscribe = RxList();
  RxList<Banner> banners = RxList();
  Rxn<BookingHistory> bookingHistoryCompleted = Rxn();
  RxList<Voucher> vouchers = RxList();
  RxString titleContent = ''.obs;
  RxString descriptionContent = ''.obs;
  RxInt dotsCount = 0.obs;
  Timer? timer;
  bool isAutoBanner = true;
  int page = 1;
  int tempPage = 1;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getBanner();
    getClasses();
    getActiveSubscribe();
    getSubContentClass();
    pageControllerListener();
  }

  void getUserProfile() async {
    profileState.value = LoadingState();
    var myCredit = Get.find<MyPref>().myCredit;
    var accessToken = Get.find<MyPref>().accessToken;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.userProfile);
      if (response == null) {
        Get.offAll(() => LoginPage(), binding: HomeBindings());
        accessToken.val = '';
      }
      var userProfile = UserProfile.fromJson(response.data['data']);
      profileState.value = SuccessState<UserProfile>(userProfile);
      checkExternalUserId(userProfile.id.toString());
      myCredit.val = userProfile.member?.remainingCredit.toString() ?? '0';
      update();
    } on DioException catch (e) {
      profileState.value = ErrorState(e.message);
      update();
      log('error user profile ${e.message}');
    }
  }

  void getBanner() async {
    bannerState.value = LoadingState();
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.banner);
      banners.value = List<Banner>.from(
          response.data["data"].map((x) => Banner.fromJson(x)));
      dotsCount.value = banners.length;
      bannerState.value = SuccessState<List<Banner>>(banners);
      update();
    } on DioException catch (e) {
      bannerState.value = ErrorState(e.message);
      update();
      log('error banner ${e.message}');
    }
  }

  void getClasses() async {
    classesState.value = LoadingState();
    update();
    try {
      final queryParameter = {'homepage': '1', 'category': 'class'};
      var response = await restApiController.get(
          endpoint: Endpoint.sportsClass, queryParameters: queryParameter);
      var classes = List<SportClass>.from(
          response.data["data"].map((x) => SportClass.fromJson(x)));
      classesState.value = SuccessState<List<SportClass>>(classes);
      update();
    } on DioException catch (e) {
      classesState.value = ErrorState(e.message);
      update();
      log('error classes ${e.message}');
    }
  }

  void getActiveSubscribe() async {
    var isSubscribe = Get.find<MyPref>().isSubscribe;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.activeSubscribe);
      activeSubscribe.value = List<ActiveSubscribe>.from(
          response.data["data"].map((x) => ActiveSubscribe.fromJson(x)));
      if (activeSubscribe.isNotEmpty) {
        isSubscribe.val = true;
      } else {
        isSubscribe.val = false;
      }
      update();
    } on DioException catch (e) {
      update();
      log('error active subscribe ${e.message}');
    }
  }

  void getCompletedBooking(List<BookingHistory>? value) {
    bookingHistoryCompleted.value = null;
    for (BookingHistory element in value ?? []) {
      if (element.status == 'Attend' && element.isUserComment == false) {
        bookingHistoryCompleted.value = element;
        return;
      } else {
        bookingHistoryCompleted.value = null;
      }
    }
    update();
  }

  String getDateSchedule(String dates) {
    try {
      final date = DateTime.parse(dates);
      final DateFormat formatter = DateFormat.EEEE();
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
      final DateFormat hourFormat = DateFormat('HH:mm');
      return '${formatter.format(date)}, ${dateFormat.format(date)} • ${hourFormat.format(date)}';
    } catch (e) {
      log('error format $e');
      return '';
    }
  }

  void reviewClass({String? rate, String? comment}) async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final id = bookingHistoryCompleted.value?.id.toString();
      final parameter = {"star_rating": rate, "comments": comment};
      if (double.parse(rate ?? '0.0') <= 0.0) {
        Get.back();
        Get.dialog(const AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: 'Please add your rating',
        ));
        return;
      }
      if ((comment?.length ?? 0) > 500) {
        Get.back();
        Get.dialog(const AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: 'Review is too long',
        ));
        return;
      }
      var response = await restApiController.post(
        endpoint: '${Endpoint.reviewClass}/$id',
        data: parameter,
      );
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog().success('Feedback Sent', () {
          Get.back();
          Get.back();
          Get.back();
        }));
        Get.find<ProfileController>().getBookingHistory();
        update();
      } else {
        Get.back();
        Get.dialog(AlertPopUpDialog(
          title: 'Review Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error review ${e.message}');
    }
  }

  void getVouchers(List<Voucher> vouchers) {
    this.vouchers.value = RxList();
    Map<String, Voucher> useVoucher = {};
    for (Voucher voucher in vouchers) {
      var key = voucher.rewardVoucher?.code ?? '';
      if (useVoucher.containsKey(key)) {
        useVoucher[key]?.totalVoucher =
            (useVoucher[key]?.totalVoucher ?? 0) + 1;
      } else {
        useVoucher[key] = voucher;
      }
    }
    useVoucher.forEach((key, value) {
      this.vouchers.add(value);
    });
    update();
  }

  void checkNotification() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.notificationCheck);
      isNewNotification.value = response?.data['is_new_notif'];
      update();
    } on DioException catch (e) {
      update();
      log('error notification check ${e.message}');
    }
  }

  void getSubContentClass() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.subContentClass);
      titleContent.value = response?.data['data']['title'];
      descriptionContent.value = response?.data['data']['description'];
      update();
    } on DioException catch (e) {
      update();
      log('error subcontent class ${e.message}');
    }
  }

  void initWebView(String url) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://hustlehouse.co.id/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> refreshHome() async {
    getUserProfile();
    getBanner();
    getClasses();
    getActiveSubscribe();
    getSubContentClass();
    automateBanner();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void automateBanner() {
    banners.removeRange(dotsCount.value, banners.length);
    page = 1;
    tempPage = 1;

    currentPage.value = 0.0;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      try {
        if (isAutoBanner) {
          pageController.animateToPage(page++,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      } catch (e) {
        timer.cancel();
      }

      update();
    });
  }

  void pageControllerListener() {
    pageController.addListener(() {
      isAutoBanner = false;
      currentPage.value = (pageController.page ?? 0.0 + 1.0) % dotsCount.value;
      if (pageController.page?.toInt() == page && tempPage <= page) {
        banners.add(banners[page - 1]);
        tempPage++;
      }
      page = (pageController.page?.toInt() ?? 0) + 1;
      if (banners.length > 50) {
        banners.removeRange(dotsCount.value, banners.length);
      }
      update();
      Future.delayed(const Duration(seconds: 2), () {
        isAutoBanner = true;
      });
    });
  }

  void checkExternalUserId(String id) async {
    var externalUserId = await OneSignal.User.getExternalId();

    if (externalUserId == null || externalUserId.isEmpty) {
      OneSignal.login(id);
    }
  }
}
