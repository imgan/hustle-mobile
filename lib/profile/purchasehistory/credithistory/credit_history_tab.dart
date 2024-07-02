import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/credit_history_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/widget/credit_valid_history_item.dart';

import '../../../utils/widgets/loading/list_loading.dart';

class CreditHistoryTab extends StatelessWidget {
  CreditHistoryTab({Key? key}) : super(key: key);

  final scrollControllerValid = ScrollController();
  final CreditHistoryController controller = Get.put(CreditHistoryController());

  @override
  Widget build(BuildContext context) {
    scrollControllerValid.addListener(() {
      if (scrollControllerValid.position.pixels >=
          (0.8 * scrollControllerValid.position.maxScrollExtent) &&
          controller.isLoadMoreCreditValid.isTrue) {
        controller.getMoreCreditValidHistory();
      }
    });
    return GetBuilder<CreditHistoryController>(builder: (context) {
      if (controller.isLoading.isTrue) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: const ListLoading(),
        );
      }
      var creditValid = controller.creditValidHistory;
      if (creditValid.isEmpty) {
        return Center(
          child: SvgPicture.asset(
            "assets/images/ic_no_credit.svg",
            height: 164,
            width: 212,
          ),
        );
      }
      return ListView.builder(
        controller: scrollControllerValid,
        primary: false,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: creditValid.length,
        itemBuilder: (context, index) {
          final creditValidHistory = creditValid.toList()[index];
          return CreditValidHistoryItem(
            creditValidHistory: creditValidHistory,
          );
        },
      );
    });
  }
}
