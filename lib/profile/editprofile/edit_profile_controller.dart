import 'dart:developer';

import 'package:dio/dio.dart' hide MultipartFile;
import 'package:dio/src/form_data.dart' as FormData;
import 'package:dio/src/multipart_file.dart' as dio;
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../model/user_profile.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/dialog/alert_dialog.dart';

class EditProfileController extends GetxController {
  Rx<PhoneNumber> number = PhoneNumber(isoCode: "ID").obs;
  PhoneNumber emergencyNumber = PhoneNumber(isoCode: "ID");

  RxString? day;
  RxString month = ''.obs;
  RxString year = ''.obs;
  RxString dateOfBirth = ''.obs;
  RxBool isLoading = false.obs;
  RxString gender = ''.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  RxString phoneNumber = ''.obs;

  RestApiController restApiController = Get.find<RestApiController>();
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Future<void> onInit() async {
    initPhoneNumber();
    super.onInit();
  }

  void getPicked(DateTime? value) async {
    day = value?.day.toString().obs ?? ''.obs;
    month.value = value?.month.toString() ?? '';
    year.value = value?.year.toString() ?? '';
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateOfBirth.value = formatter.format(value ?? DateTime.now());
    update();
  }

  Future<void> pickImage({required ImageSource source}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 100);
      final int imageSize = await pickedImage!.length();
      if (imageSize <= 2000000) {
        this.pickedImage.value = XFile(pickedImage.path);
        update();
        uploadImage();
        return;
      }
    } catch (e) {
      log('Error picking image: $e');
      update();
    }
  }

  void uploadImage() async {
    isLoading.value = true;
    update();
    try {
      var parameter = FormData.FormData.fromMap({
        'image': [
          await dio.MultipartFile.fromFile(pickedImage.value!.path,
              filename: pickedImage.value!.name)
        ],
      });
      var response = await restApiController.post(
          endpoint: Endpoint.editProfilePhoto, data: parameter);
      isLoading.value = false;
      update();
      if (response.data['code'] == 200) {
        profileController.getUserProfile();
        Get.find<HomeController>().getUserProfile();
        profileController.update();
        Get.dialog(CustomDialog().success(
          response.data['message'],
          () {
            Get.back();
          },
        ));
        update();
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Upload Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error editing profile picture ${e.message}');
    }
  }

  void deleteImage() async {
    isLoading.value = true;
    update();
    try {
      var response = await restApiController.post(
        endpoint: Endpoint.deleteProfilePhoto,
      );
      isLoading.value = false;
      update();
      if (response.data['code'] == 200) {
        profileController.getUserProfile();
        Get.find<HomeController>().getUserProfile();
        profileController.update();
        Get.back();
        Get.dialog(CustomDialog().success(
          response.data['message'],
          () {
            Get.back();
          },
        ));
        update();
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Delete Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error editing profile picture ${e.message}');
    }
  }

  void editProfile(
      {String? firstName,
      String? lastName,
      String? phone,
      String? gender,
      String? address,
      String? emergencyName,
      String? emergencyPhone}) async {
    isLoading.value = true;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateOfBirthFormated = formatter.format(
        profileController.userProfile.value?.member?.dateOfBirth ??
            DateTime.now());

    update();
    try {
      var parameter = FormData.FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "dateOfBirth":
            dateOfBirth.value == '' ? dateOfBirthFormated : dateOfBirth.value,
        "gender": gender,
        "address": address,
        "emergencyName": emergencyName,
        "emergencyPhone": emergencyPhone,
      });
      var response = await restApiController.post(
          endpoint: Endpoint.editProfile, data: parameter);
      profileController.userProfile.value =
          UserProfile.fromJson(response.data['data']);
      isLoading.value = false;
      Get.find<HomeController>().getUserProfile();
      update();
      if (response?.statusCode == 200) {
        Get.dialog(CustomDialog().success(response?.data['message'], () {
          Get.back();
        }));
        update();
      } else {
        Get.dialog(AlertPopUpDialog(
          title: 'Edit Failed',
          subTitle: response?.data['message'],
        ));
        update();
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error editing profile ${e.message}');
    }
  }

  initPhoneNumber() async {
    number.value = await PhoneNumber.getRegionInfoFromPhoneNumber(
        profileController.userProfile.value?.member?.phone ?? '');
    phoneNumber.value = profileController.userProfile.value?.member?.phone
            ?.replaceAll('+${number.value.dialCode}', '') ??
        '';
    update();
  }
}
