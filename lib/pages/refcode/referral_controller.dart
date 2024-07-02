import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';

import '../../model/referral_code.dart';
import '../../model/referral_list.dart';
import '../../utils/api/endpoint.dart';

class ReferralController extends GetxController {
  Rxn<ReferralCode> referralCode = Rxn();
  RxList<Referrer> referralList = RxList();
  RxBool isShowMore = false.obs;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    _getReferralCode();
    _getReferralList();
    super.onInit();
  }

  void _getReferralCode() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.referralCode);
      referralCode.value = ReferralCode.fromJson(response.data);
      update();
    } on DioException catch (e) {
      log('error referral code ${e.message}');
    }
  }

  void _getReferralList() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.referralList);
      referralList.value = List<Referrer>.from(
          response.data["data"].map((x) => Referrer.fromJson(x)));
      isShowMore.value = referralList.length > 3 ? true : false;
      update();
    } on DioException catch (e) {
      log('error referral list ${e.message}');
    }
  }

  void updateShowMore() {
    isShowMore.value = !(isShowMore.value);
    update();
  }
}
