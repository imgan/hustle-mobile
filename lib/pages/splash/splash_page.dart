import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<SplashController>(builder: (_) {
          return Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 750),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return child;
              },
              child: Image.asset(
                controller.splashAssets[controller.index.value],
                height: 53,
                key: ValueKey<int>(controller.index.value),
              ),
            ),
          );
        }));
  }
}
