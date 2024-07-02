import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/purchase_list.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../../utils/widgets/custom_dialog.dart';
import '../../../utils/widgets/custom_web_view.dart';
import '../../../utils/widgets/error/error_book.dart';
import '../../main/main_controller.dart';

class PurchaseWaitingController extends GetxController {
  RxList<PurchaseList> purchaseList = RxList();
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  int page = 1;
  bool isDirectToGopay = false;

  late WebViewController webViewController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getPurchaseList();
    super.onInit();
  }

  void getPurchaseList() async {
    isLoading.value = true;
    isLoadMore.value = false;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 8, 'type': 'waiting'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.value = List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value = true;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

  void getMorePurchaseList() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 8, 'type': 'waiting'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.addAll(List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x))));
      isLoadMore.value =
          (purchaseList.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

  void paymentMidtrans(String url) async {
    await initWebView(url);
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
            Get.find<ProfileController>().getTotalPurchaseList();
            return true;
          },
        ));
  }

  void cancelMidtrans(String code) async {
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      final parameter = {"code": code};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelMidtrans, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.back();
        Get.find<ProfileController>().getTotalPurchaseList();
        Get.dialog(CustomDialog().success('Order Cancelled', () {
          Get.until((route) => Get.currentRoute == '/MainPage');
        }));
        update();
      } else {
        Get.back();
        errorBook('Cancel Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error cancel order ${e.message}');
    }
  }

  Future<void> initWebView(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
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
              if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication)) {
                await launchUrl(url);
              }
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

  void goToProfile() {
    Get.until((route) => Get.currentRoute == '/MainPage');
    Get.find<MainController>().updateIndex(3);
  }
}
