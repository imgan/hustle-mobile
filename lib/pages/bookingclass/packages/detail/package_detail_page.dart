import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/widgets/policy_package_section.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/widgets/title_package_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/image/image_cover.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading_detail.dart';

import '../../../../utils/colors.dart';
import 'widgets/button_package_section.dart';

class PackageDetailPage extends StatelessWidget {
  PackageDetailPage({super.key});

  final controller = Get.put(PackageDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Package Details',
      ),
      body: GetBuilder<PackageDetailController>(builder: (context) {
        if (controller.isLoading.isTrue) {
          return const LoadingDetail();
        }
        var package = controller.package.value;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageCover(url: package?.imageUrl ?? ''),
                    TitlePackageSection(package: package),
                    Divider(
                      thickness: 1,
                      color: disableColor,
                    ),
                    const PolicyPackageSection(),
                  ],
                ),
              ),
            ),
            const ButtonPackageSection()
          ],
        );
      }),
    );
  }
}
