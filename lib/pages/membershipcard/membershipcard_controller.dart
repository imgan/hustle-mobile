import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/termconditions/model/termcondition.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import 'model/membershipcode.dart';

class MembershipCardController extends GetxController {
  late WebViewController webViewController;
  RxList<TermConditionData> termConditionData = RxList();
  var memberData = MembershipCodeData().obs;
  var membershipCodeData = ''.obs;
  var isActive = 1.obs;
  var expiredDate = ''.obs;
  RxBool isLoading = true.obs;
  RxString name = ''.obs;
  RxString url = ''.obs;
  var arguments = Get.arguments;

  RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    super.onInit();
    fetchMembershipTermServiceFromApi();
    fetchMembershipCodeFromApi();
    name.value = arguments;
  }

  void fetchMembershipTermServiceFromApi() async {
    try {
      isLoading.value = true;
      var response = await restApiController.get(
          endpoint: Endpoint.termAndServicesMembership);
      if (response.data['status'] == true) {
        termConditionData.value = List<TermConditionData>.from(
            response.data["data"].map((x) => TermConditionData.fromJson(x)));
        url.value = getUrl(termConditionData[0].description1.replaceAll('"', '')) ?? '';
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error fetch term condition data ${e.message}');
    }
  }

  void fetchMembershipCodeFromApi() async {
    try {
      isLoading.value = true;
      var response = await restApiController.get(endpoint: Endpoint.memberCode);
      if (response.data['status'] == true) {
        membershipCodeData.value = response.data['data']['membershipCode'];
        expiredDate.value = response.data['data']['expired_date'];
        isActive.value = response.data['data']['isActive'];
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error fetch membershipcode data ${e.message}');
    }
  }

  void initWebView() {
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
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url.value));
  }

  String? getUrl(String description) {
    RegExp regex = RegExp(r'https?://\S+|www\.\S+');
    Iterable<Match> matches = regex.allMatches(description);

    List<String?> urls = matches.map((match) => match.group(0)).toList();

    for (String? url in urls) {
      return url;
    }
    return '';
  }
}
