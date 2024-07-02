import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../model/comment.dart';
import '../../model/rating.dart';
import '../../model/review.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';

class ReviewController extends GetxController {
  RxBool isLoadingReview = true.obs;
  RxBool isLoadMore = false.obs;
  var arguments = Get.arguments;
  Rxn<Review> review = Rxn();
  RxList<Comment> comments = RxList();
  int page = 1;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getReview();
    super.onInit();
  }

  void getReview() async {
    isLoadingReview.value = true;
    isLoadMore.value = false;
    update();
    try {
      final id = arguments[0];
      final queryParameter = {getParameter(): id, 'page': page, 'limit': 7};
      var response = await restApiController.get(
          endpoint: getEndpoint(), queryParameters: queryParameter);
      review.value = Review.fromJson(response?.data);
      comments.value = List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x)));
      isLoadingReview.value = false;
      isLoadMore.value = true;
      update();
    } on DioException catch (e) {
      isLoadingReview.value = false;
      isLoadMore.value = false;
      update();
      log('error review ${e.message}');
    }
  }

  void getMoreReview() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final id = arguments[0];
      final queryParameter = {getParameter(): id, 'page': page, 'limit': 7};
      var response = await restApiController.get(
          endpoint: getEndpoint(), queryParameters: queryParameter);
      comments.addAll(List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x))));
      isLoadMore.value = (comments.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error review ${e.message}');
    }
  }

  String getEndpoint() {
    return switch (Get.previousRoute) {
      '/ClassDetailPage' => Endpoint.reviewSportClass,
      '/TrainerDetail' => Endpoint.reviewTrainer,
      '/RecoveryDetailPage' => Endpoint.reviewRecovery,
      _ => Endpoint.reviewSportClass
    };
  }

  String getParameter() {
    return switch (Get.previousRoute) {
      '/ClassDetailPage' => 'sportsClassID',
      '/TrainerDetail' => 'teacherID',
      '/RecoveryDetailPage' => 'sportsClassID',
      _ => 'sportsClassID'
    };
  }

  Map<int, double> getPercentage() {
    Map<int, double> map = {};
    for (Rating rate in review.value?.ratings ?? []) {
      map[rate.rating ?? 0] = rate.percentage ?? 0.0;
    }
    return map;
  }
}
