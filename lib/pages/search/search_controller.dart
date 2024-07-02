import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../model/search.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/my_pref.dart';

class SearchHomeController extends GetxController {
  Timer? debounce;
  RxBool isLoading = false.obs;
  RxBool isShowCancel = false.obs;
  RxBool isSearch = false.obs;
  RxString message = ''.obs;
  RxList<Search> search = RxList();
  List<String> tempRecent = [];

  final RestApiController restApiController = Get.find<RestApiController>();
  var recentSearch = Get.find<MyPref>().recentSearch;

  void onSearchChanged(String query) {
    isLoading.value = true;
    update();
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        doSearch(query);
      } else {
        isLoading.value = false;
      }
      update();
    });
  }

  void doSearch(String keyword) async {
    isLoading.value = true;
    search.value = RxList();
    message.value = '';
    update();
    try {
      final queryParameter = {'keyword': keyword};
      var response = await restApiController.get(
          endpoint: Endpoint.search, queryParameters: queryParameter);
      search.value = List<Search>.from(
          response.data["data"].map((x) => Search.fromJson(x)));

      if (search.isEmpty) {
        message.value = 'We can’t find any matches for “$keyword”';
      } else {
        recentSearch.val.add(keyword);
        recentSearch.val = recentSearch.val;
        if (recentSearch.val.length > 5) {
          recentSearch.val.removeAt(0);
        }
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error search ${e.message}');
    }
  }

  void updateShowCancel(bool value) {
    isShowCancel.value = value;
    update();
  }

  void updateSearch(bool value) {
    isSearch.value = value;
    message.value = '';
    update();
  }

  void clearRecentSearch() {
    recentSearch.val = [];
    update();
  }
}
