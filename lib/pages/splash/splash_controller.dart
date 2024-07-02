import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/pages/main/main_page.dart';
import 'package:hustle_house_flutter/pages/onboarding/onboarding_page.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';

class SplashController extends GetxController {
  List<String> splashAssets = [
    "assets/images/splash_1.png",
    "assets/images/splash_2.png",
    "assets/images/splash_3.png",
    "assets/images/splash_4.png",
  ];

  RxInt index = 0.obs;

  void initAnimation() async {
    showSplash();
    Future.delayed(const Duration(seconds: 1), () {
      var onBoarding = Get.find<MyPref>().isOnBoarding;
      var accessToken = Get.find<MyPref>().accessToken.val;
      if (accessToken.isNotEmpty) {
        return Get.offAll(() => MainPage());
      }
      if (!onBoarding.val) {
        Get.offAll(() => OnBoardingPage());
        onBoarding.val = true;
      } else {
        Get.offAll(() => LoginPage());
      }
    });
  }

  void showSplash() async {
    for (int i = 0; i < splashAssets.length; i++) {
      index.value = i;
      await Future.delayed(const Duration(milliseconds: 187), () {});
      update();
    }
  }

  @override
  void onInit() {
    initAnimation();
    super.onInit();
  }
}
