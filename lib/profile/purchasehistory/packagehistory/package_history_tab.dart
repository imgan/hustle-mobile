import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_page.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/packagehistory/package_history_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/packagehistory/widget/package_history_item.dart';

import '../../../utils/widgets/loading/list_loading.dart';

class PackageHistoryTab extends StatelessWidget {
  PackageHistoryTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final controller = Get.put(PackageHistoryController());

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.8 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMorePackageHistory();
      }
    });

    return GetBuilder<PackageHistoryController>(builder: (context) {
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: const ListLoading(),
        );
      }
      if (controller.packageHistory.isEmpty) {
        return Center(
          child: SvgPicture.asset(
            "assets/images/ic_no_package.svg",
            height: 164,
            width: 212,
          ),
        );
      }
      return ListView.builder(
        primary: false,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        shrinkWrap: true,
        itemCount: controller.packageHistory.length,
        itemBuilder: (context, index) {
          final packageHistory = controller.packageHistory[index];
          return PackageHistoryItem(
            packageHistory: packageHistory,
            onTap: () {
              Get.to(() => PackageDetailPage(),
                  arguments: [packageHistory.packageId]);
            },
          );
        },
      );
    });
  }
}
