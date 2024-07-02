import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../model/package_first_timer.dart';
import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/widgets/dialog/alert_dialog.dart';
import '../../../checkout/checkout_package_page.dart';

class PackageDetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingOrder = false.obs;
  RxBool isReadMore = false.obs;
  Rxn<Package> package = Rxn();
  var arguments = Get.arguments;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getPackage();
    super.onInit();
  }

  void getPackage() async {
    isLoading.value = true;
    update();
    try {
      final id = arguments[0];
      var response =
          await restApiController.get(endpoint: '${Endpoint.package}/$id');
      package.value = Package.fromJson(response.data["data"]);
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error package ${e.message}');
    }
  }

  Future<void> orderPackage(String id) async {
    isLoadingOrder.value = true;
    update();
    try {
      var parameter = {"packageID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.orderPackage, data: parameter);
      if (response?.data['status'] == true) {
        Get.to(() => CheckoutPackagePage());
      } else {
        Get.dialog( AlertPopUpDialog(
          title: 'Order Failed',
          subTitle: response?.data['message'],
        ));
      }
      isLoadingOrder.value = false;
      update();
    } on DioException catch (e) {
      isLoadingOrder.value = false;
      update();
      log('error order ${e.message}');
    }
  }

  void updateReadMore() {
    isReadMore.value = !isReadMore.value;
    update();
  }
}
