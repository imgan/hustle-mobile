import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/result.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../model/banner.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/custom_web_view.dart';
import '../../../utils/widgets/loading/loading.dart';
import 'item_banner.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    controller.automateBanner();
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: GetBuilder<HomeController>(builder: (_) {
        return switch (controller.bannerState.value) {
          LoadingState() => const Loading(
              height: 200,
            ),
          ErrorState(error: var err) => Text(err ?? ''),
          SuccessState<List<Banner>>(result: var res) => Stack(
              children: [
                SizedBox(
                  height: Get.width / 2,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: res?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final banner = res?[index];
                      return ItemBanner(
                        title: banner?.title,
                        description: banner?.description,
                        image: banner?.imageUrl,
                        onTap: () {
                          controller.initWebView(
                              banner?.link ?? 'https://hustlehouse.co.id/');
                          Get.to(() => CustomWebView(
                              title: banner?.title ?? '',
                              webViewController: controller.webViewController));
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 19,
                  bottom: 14,
                  child: DotsIndicator(
                    dotsCount: controller.dotsCount.value,
                    position: controller.currentPage.value,
                    decorator: DotsDecorator(
                      color: Colors.white,
                      spacing: const EdgeInsets.symmetric(horizontal: 4),
                      activeColor: primaryColor,
                      size: const Size(8, 8),
                      activeSize: const Size(16.0, 8),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          _ => const SizedBox()
        };
      }),
    );
  }
}
