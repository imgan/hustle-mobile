import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class OtpSuccessController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> offset;

  Future<void> initAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
    offset = Tween<double>(begin: 0, end: 1.0).animate(animationController);
    animationController.repeat(reverse: true);
  }

  @override
  void onInit() {
    initAnimation();
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
