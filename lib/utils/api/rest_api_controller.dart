import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';

import 'interceptor.dart';

class RestApiController extends GetxController {
  static String baseUrl = getBaseUrl();

  Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  RxString accessToken = Get.find<MyPref>().accessToken.val.obs;

  @override
  void onInit() {
    dio.interceptors.add(ApiInterceptors());
    super.onInit();
  }

  void updateAccessToken(String value) {
    accessToken.value = value;
    update();
  }

  Future get(
      {required String endpoint,
      String? contentType,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-type": contentType,
            "Authorization": "Bearer ${accessToken.value}",
          },
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) < 500;
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      log(e.message ?? '');
    }
  }

  Future post(
      {required String endpoint,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      String? contentType = "application/json",
      String? token}) async {
    try {
      var response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-type": contentType,
            "Authorization": "Bearer ${accessToken.value}",
            "token": token
          },
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) < 500;
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      log(e.message.toString());
    }
  }

  Future put({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? contentType,
  }) async {
    try {
      var response = await dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-type": contentType,
            "Authorization": "Bearer ${accessToken.value}",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      log(e.message ?? '');
    }
  }

  Future delete({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? contentType,
  }) async {
    try {
      var response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-type": contentType,
            "Authorization": "Bearer ${accessToken.value}",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      log(e.message ?? '');
    }
  }
}
