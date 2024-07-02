import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/onemonthpackagelist/package_controller.dart';

import '../../../../utils/widgets/loading/loading.dart';
import 'item_list_one_month_package.dart';

class PackageSection extends StatelessWidget {
  const PackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PackageController>();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: GetBuilder<PackageController>(builder: (_) {
        if (controller.isLoading.isTrue) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Loading(
                  height: 250,
                );
              },
              separatorBuilder: (index, context) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 4);
        }
        return ListView.builder(
            itemCount: controller.package.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final package = controller.package[index];
              return ItemListMonthPackage(
                package: package,
              );
            });
      }),
    );
  }
}
