import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/order.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../profile/profile_controller.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/custom_dialog.dart';
import '../../utils/widgets/custom_web_view.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';
import '../../utils/widgets/error/error_book.dart';
import '../bookingclass/packages/detail/package_detail_controller.dart';
import '../home/home_controller.dart';
import '../main/main_controller.dart';

class CheckoutPackageController extends GetxController {
  RxBool isLoading = true.obs;
  Rxn<Order> order = Rxn();
  RxString discountCode = "Enter discount code".obs;
  RxBool isRemoveOrder = true.obs;
  bool isDirectToGopay = false;
  RxBool isRemoveVoucher = true.obs;
  bool isHideQuery = false;

  late WebViewController webViewController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getOrder();
    super.onInit();
  }

  Future<void> getOrder() async {
    isLoading.value = true;
    discountCode.value = "Enter discount code";
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.orderCart);
      order.value = Order.fromJson(response.data["data"]);
      validateCart();
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error order ${e.message}');
    }
  }

  Future<void> removeOrder() async {
    try {
      for (final packageOrder in order.value?.packages ?? []) {
        final id = packageOrder.packageId.toString();
        var parameter = {"packageID": id};
        await restApiController.post(
            endpoint: Endpoint.orderPackageRemove, data: parameter);
      }
      update();
    } on DioException catch (e) {
      log('error remove order ${e.message}');
    }
  }

  void paymentMidtrans() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final code =
          discountCode.value == 'Enter discount code' ? '' : discountCode.value;
      var parameter = {
        "priceTotal": order.value?.subTotal,
        "discountCode": code,
        "discountValue": order.value?.totalDiscount,
        "code": order.value?.code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.midtransFirstTime, data: parameter);
      isRemoveVoucher.value = false;
      Get.back();
      orderTotalZero();
      final url = response?.data['data']['redirect_url'];
      await initWebView(url);
      isRemoveOrder.value = false;
      Get.to(() => CustomWebView(
            title: 'Payment',
            webViewController: webViewController,
            onWillPop: () async {
              if (isDirectToGopay) {
                goToProfile();
                isDirectToGopay = false;
                return false;
              }
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
                return false;
              } else {
                goToProfile();
              }
              return true;
            },
          ));
      update();
    } on DioException catch (e) {
      log('error midtrans ${e.message}');
    }
  }

  Future<void> initWebView(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (Platform.isAndroid &&
                (request.url.contains("gojek://") ||
                    request.url.contains("gojek.link") ||
                    request.url.contains("gopayapp.page.link"))) {
              String reqUrl = request.url;
              final Uri url = Uri.parse(reqUrl);
              await launchUrl(url);
              isDirectToGopay = true;
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('${getBaseUrl()}/')) {
              Get.until((route) => Get.currentRoute == '/MainPage');
              Get.find<MainController>().updateIndex(3);
              return NavigationDecision.prevent;
            }
            if (Platform.isIOS &&
                request.url
                    .contains("https://gopay.co.id/app/merchanttransfer")) {
              final Uri url = Uri.parse(request.url);
              if (!await launchUrl(url,
                  mode: LaunchMode.externalNonBrowserApplication)) {
                await launchUrl(url);
              }
              isDirectToGopay = true;
              return NavigationDecision.prevent;
            }
            if (Platform.isAndroid && request.url.contains('blob')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void packageMonthlyPayment() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final orderId = order.value?.id.toString();
      final parameter = {"order_id": orderId};
      var response = await restApiController.post(
          endpoint: Endpoint.orderProcessMonthly, data: parameter);
      final isSuccess = (response?.data['message']
              .toString()
              .toLowerCase()
              .contains('success') ??
          false);
      if (response?.data['status'] == true && isSuccess) {
        updateProfile();
        Get.dialog(CustomDialog().success(response?.data['message'], () {
          Get.until((route) => Get.currentRoute == '/MainPage');
          Get.find<MainController>().updateIndex(3);
        }));
      } else {
        Get.back();
        errorBook('Checkout Failed', response?.data);
      }
      update();
    } on DioException catch (e) {
      update();
      log('error order process package ${e.message}');
    }
  }

  Future<void> discountFirstTime(String code) async {
    isLoading.value = true;
    discountCode.value = "Enter discount code";
    await removeVoucher();
    update();
    try {
      final orderId = order.value?.id.toString();
      final queryParameter = {"order_id": orderId, "code": code};
      var response = await restApiController.post(
          endpoint: Endpoint.redeemVoucher, queryParameters: queryParameter);
      if (response.data["data"] == null) {
        Get.dialog(AlertPopUpDialog(
          title: 'Order Failed',
          subTitle: response.data['errors']['package'][0],
        ));
      } else {
        order.value = Order.fromJson(response.data["data"]);
        if (code.isNotEmpty) {
          discountCode.value = code;
        }
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error discount first time ${e.message}');
    }
  }

  Future<void> removeVoucher() async {
    try {
      final orderId = order.value?.id.toString();
      var parameter = {"orderID": orderId};
      await restApiController.post(
          endpoint: Endpoint.removeVoucher, data: parameter);
      update();
    } on DioException catch (e) {
      log('error remove voucher ${e.message}');
    }
  }

  void validateCart() async {
    var id = order.value?.packages?[0].package?.id;
    var quantity = order.value?.packages?[0].quantity;
    var totalDiscount = order.value?.totalDiscount;
    var totalPackages = order.value?.packages?.length;
    bool isValidate = (totalPackages ?? 0) > 1 ||
        (totalDiscount ?? 0) > 0 ||
        (quantity ?? 0) > 1;
    if (isValidate) {
      await removeOrder();
      await reOrder(id.toString());
      getOrder();
    }
  }

  Future<void> reOrder(String id) async {
    if (Get.previousRoute == '/MainPage' || Get.previousRoute == '/CheckoutFirstPackagePage') {
      await Get.find<CreditController>().orderFirstTime(id);
    } else if (Get.previousRoute == '/PackageDetailPage') {
      await Get.find<PackageDetailController>().orderPackage(id);
    }
  }

  void updateProfile() {
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().fetchMembershipCodeFromApi();
    Get.find<ProfileController>().getPackageHistory();
    Get.find<HomeController>().getActiveSubscribe();
    Get.find<ProfileController>().getActiveSubscribe();
  }

  void goToProfile() {
    Get.until((route) => Get.currentRoute == '/MainPage');
    Get.find<MainController>().updateIndex(3);
  }

  void updateIsHideQuery(bool value) {
    isHideQuery = value;
  }

  void orderTotalZero() {
    if (order.value?.total == 0) {
      isRemoveVoucher.value = false;
      isRemoveOrder.value = false;
      Get.dialog(CustomDialog().success("Purchase successful!", () {
        goToProfile();
      }));

      return;
    }

  }

  @override
  void onClose() {
    if (isRemoveOrder.isTrue) {
      removeOrder();
    }
    if (isRemoveVoucher.isTrue) {
      removeVoucher();
    }
    super.onClose();
  }
}
