import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/checkout/checkout_book_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/class_detail_controller.dart';
import 'package:hustle_house_flutter/pages/book/recovery/book/book_recovery_controller.dart';
import 'package:hustle_house_flutter/pages/book/trainer/book/book_pt_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class_schedule/class_schedule_controller.dart';
import 'package:hustle_house_flutter/pages/voucher/argument_use_voucher.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';

import '../../../model/voucher.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../checkout/checkout_credit_controller.dart';
import '../../checkout/checkout_package_controller.dart';

class UseVoucherController extends GetxController {
  RxString selectedVoucher = ''.obs;
  RxBool isLoading = false.obs;
  RxString message = ''.obs;
  RxList<Voucher> vouchers = RxList();
  RxBool isDisableButton = true.obs;
  bool isHideQuery = false;
  var arguments = Get.arguments;

  Timer? debounce;
  int type = 1;
  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() async {
    type = arguments[ArgumentUseVoucher.type];
    await removeVoucherPackage();
    await removeVoucherCredit();
    if (isGetAvailableVoucher() &&
            arguments[ArgumentUseVoucher.hideQuery] == false ||
        arguments[ArgumentUseVoucher.hideQuery] == null) {
      getAvailableVoucher(query: getQuery());
    } else {
      getSearchVoucher('');
    }
    checkUsedVoucher();
    super.onInit();
  }

  void getAvailableVoucher({String? query}) async {
    isLoading.value = true;
    message.value = '';
    selectedVoucher.value = '';
    vouchers.value = RxList();
    List<Voucher> responseVoucher = [];
    update();
    try {
      final queryParameter = {
        'type': type,
        'code': (arguments[ArgumentUseVoucher.hideQuery] ?? false) ? '' : query
      };
      var response = await restApiController.get(
          endpoint:
              type == 1 ? Endpoint.searchVoucher : Endpoint.availableVoucher,
          queryParameters: queryParameter);
      final isList = response?.data["data"] is List;
      if (isList) {
        responseVoucher = List<Voucher>.from(
            response.data["data"].map((x) => Voucher.fromJson(x)));
        getUseVouchers(responseVoucher);
      } else {
        vouchers.add(Voucher.fromJson(response?.data["data"]));
      }

      String name = type == 1 ? 'Discount' : 'Voucher';
      if (vouchers.isEmpty && (query?.isEmpty ?? false || query == null)) {
        message.value = '$name not found';
      } else if (vouchers.isEmpty && (query?.isNotEmpty ?? false)) {
        message.value = '$name codes do not exist';
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error voucher ${e.message}');
    }
  }

  void getSearchVoucher(String code) async {
    isLoading.value = true;
    message.value = '';
    vouchers.value = RxList();
    selectedVoucher.value = '';
    update();
    try {
      final queryParameter = {'code': code};
      var response = await restApiController.get(
          endpoint: Endpoint.searchVoucher, queryParameters: queryParameter);
      if (response.data['status'] == true && response.data["data"].isNotEmpty) {
        try {
          vouchers.value = List<Voucher>.from(
              response.data["data"].map((x) => Voucher.fromJson(x)));
        } catch (e) {
          vouchers.add(Voucher.fromJson(response.data['data']));
        }
        selectedVoucher.value = getSelectedVoucher();
        if (getSelectedVoucher().isEmpty) {
          message.value = 'Discount codes do not exist';
        }
        if (code.isEmpty) {
          isHideQuery = true;
        }
      } else {
        message.value = 'Discount codes do not exist';
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error voucher ${e.message}');
    }
  }

  updateSelectedVoucher(String value) {
    if (selectedVoucher.value == value) {
      selectedVoucher.value = '';
    } else {
      selectedVoucher.value = value;
    }
    update();
  }

  void getUseVouchers(List<Voucher> vouchers) {
    Map<String, Voucher> useVoucher = {};
    final type = arguments[ArgumentUseVoucher.type];
    for (Voucher voucher in vouchers) {
      var key = type == 1 ? voucher.code : voucher.rewardVoucher?.code ?? '';
      if (useVoucher.containsKey(key)) {
        useVoucher[key]?.totalVoucher =
            (useVoucher[key]?.totalVoucher ?? 0) + 1;
      } else {
        useVoucher[key ?? ''] = voucher;
      }
    }
    useVoucher.forEach((key, value) {
      this.vouchers.add(value);
    });
  }

  onSearchChanged(String query) {
    isLoading.value = true;
    update();
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        if (type != 1) {
          getAvailableVoucher();
        }
        isLoading.value = false;
        update();
      } else {
        if (type == 1) {
          getSearchVoucher(query);
        } else {
          getAvailableVoucher(query: query);
        }
      }
    });
  }

  void useDiscount() async {
    switch (arguments[ArgumentUseVoucher.currentRoute]) {
      case '/CheckoutFirstPackagePage':
        Get.find<CheckoutPackageController>().updateIsHideQuery(isHideQuery);
        if (selectedVoucher.value.isNotEmpty) {
          await Get.find<CheckoutPackageController>()
              .discountFirstTime(selectedVoucher.value);
        } else {
          await Get.find<CheckoutPackageController>().getOrder();
        }
        break;
      case '/CheckoutCreditPage':
        Get.find<CheckoutCreditController>().updateIsHideQuery(isHideQuery);
        if (selectedVoucher.value.isNotEmpty) {
          await Get.find<CheckoutCreditController>()
              .discountCredit(selectedVoucher.value);
        } else {
          await Get.find<CheckoutCreditController>().getOrderCredit();
        }
      case '/ClassDetailPage':
        await Get.find<ClassDetailController>()
            .sessionSubTotal(code: selectedVoucher.value);
        Get.find<ClassDetailController>()
            .updateCodeVoucher(selectedVoucher.value);
        Get.find<CheckoutBookController>().updateCheckoutBook();
        break;
      case '/BookPTPage':
        await Get.find<BookPTController>()
            .sessionSubTotal(code: selectedVoucher.value);
        Get.find<BookPTController>().updateCodeVoucher(selectedVoucher.value);
        Get.find<CheckoutBookController>().updateCheckoutBook();
        break;
      case '/BookRecoveryPage':
        await Get.find<BookRecoveryController>()
            .sessionSubTotal(code: selectedVoucher.value);
        Get.find<BookRecoveryController>()
            .updateCodeVoucher(selectedVoucher.value);
        Get.find<CheckoutBookController>().updateCheckoutBook();
        break;
      case '/ClassSchedulePage':
        await Get.find<ClassScheduleController>()
            .sessionSubTotalWithCode(code: selectedVoucher.value);
        Get.find<ClassScheduleController>()
            .updateCodeVoucher(selectedVoucher.value);
        Get.find<CheckoutBookController>().updateCheckoutBook();
        break;
    }
  }

  void checkUsedVoucher() {
    if (arguments[ArgumentUseVoucher.usedVoucher] != null) {
      final isValid =
          arguments[ArgumentUseVoucher.usedVoucher].toString().toLowerCase() !=
              "enter discount code";
      selectedVoucher.value =
          isValid ? arguments[ArgumentUseVoucher.usedVoucher] : '';
      update();
    }
  }

  bool isDisable({String? category, int? locationID}) {
    final type = arguments[ArgumentUseVoucher.type];
    if (type == 1) return false;
    return isDisableVoucher(category ?? '', locationID);
  }

  bool isDisableVoucher(String category, int? locationID) {
    bool isDisableCategory = false;
    bool isDisableLocation = false;
    if (arguments[ArgumentUseVoucher.category] != null) {
      isDisableCategory = !arguments[ArgumentUseVoucher.category]
          .toString()
          .toLowerCase()
          .contains(category);
    }
    if (locationID != null) {
      isDisableLocation =
          !(arguments[ArgumentUseVoucher.locationID] == locationID);
    }
    if (isDisableCategory || isDisableLocation) {
      return true;
    }
    return false;
  }

  bool isHidePromoCode(List<dynamic>? packages, List<dynamic>? credits) {
    final type = arguments[ArgumentUseVoucher.type];
    final category = arguments[ArgumentUseVoucher.promoCodeCategory];

    if ((packages?.isEmpty ?? false) && (credits?.isEmpty ?? false) ||
        type == 2) {
      return false;
    }
    if (category == 'credit') {
      return credits?.isEmpty ?? false;
    }
    return packages?.isEmpty ?? false;
  }

  String getSelectedVoucher() {
    final type = arguments[ArgumentUseVoucher.type];
    final category = arguments[ArgumentUseVoucher.promoCodeCategory];

    for (Voucher voucher in vouchers) {
      if ((voucher.packages?.isEmpty ?? false) &&
              (voucher.credits?.isEmpty ?? false) ||
          type == 2) {
        return voucher.code ?? '';
      }
      if (category == 'credit' && (voucher.credits?.isNotEmpty ?? false)) {
        return voucher.code ?? '';
      }
      if (category == 'first time' && (voucher.packages?.isNotEmpty ?? false)) {
        return voucher.code ?? '';
      }
    }
    return vouchers[0].code ?? '';
  }

  bool isGetAvailableVoucher() {
    final isValid =
        arguments[ArgumentUseVoucher.usedVoucher].toString().toLowerCase() !=
            "enter discount code";
    return type != 1 || isValid;
  }

  String getQuery() {
    final isValid =
        arguments[ArgumentUseVoucher.usedVoucher].toString().toLowerCase() !=
            "enter discount code";
    return isValid ? arguments[ArgumentUseVoucher.usedVoucher] : '';
  }

  void clearSelectedVoucher() {
    selectedVoucher.value = '';
    isDisableButton.value = true;
    vouchers.value = RxList();
    update();
  }

  void updateDisableButton(String value) {
    isDisableButton.value = value.isEmpty;
    update();
  }

  Future<void> removeVoucherPackage() async {
    if (!Get.isRegistered<CheckoutPackageController>()) {
      return;
    }
    if (arguments[ArgumentUseVoucher.hideQuery]) {
      await Get.find<CheckoutPackageController>().removeVoucher();
    }
  }

  Future<void> removeVoucherCredit() async {
    if (!Get.isRegistered<CheckoutCreditController>()) {
      return;
    }
    if (arguments[ArgumentUseVoucher.hideQuery]) {
      await Get.find<CheckoutCreditController>().removeVoucher();
    }
  }
}
