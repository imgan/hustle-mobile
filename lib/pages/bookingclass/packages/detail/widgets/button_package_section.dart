import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_controller.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets/floating_button.dart';

class ButtonPackageSection extends StatelessWidget {
  const ButtonPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageDetailController>(builder: (_) {
      final controller = Get.find<PackageDetailController>();
      final bool isFromPurchaseHistory =
          Get.previousRoute == "/PurchaseHistoryPage";
      final id = controller.package.value?.id.toString();
      if (controller.isLoadingOrder.isTrue) {
        return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      }
      return Visibility(
        visible: !isFromPurchaseHistory,
        child: FloatingButton(
          text: 'Buy Package',
          colorButton: primaryColor,
          textColor: Colors.black,
          onPressed: () {
            controller.orderPackage(id ?? '0');
          },
        ),
      );
    });
  }
}
