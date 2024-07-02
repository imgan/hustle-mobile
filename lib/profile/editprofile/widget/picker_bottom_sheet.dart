import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/editprofile/edit_profile_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../utils/widgets/custom_dialog.dart';
import '../../profile_controller.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  ImagePickerBottomSheet({
    super.key,
  });

  final EditProfileController controller = Get.put(EditProfileController());
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  size: 28,
                ),
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: Text(
                  'Choose Image Source',
                  textAlign: TextAlign.center,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
          Divider(thickness: 10, color: gray1),
          TextButton(
            child: Text(
              'Camera',
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              controller.pickImage(source: ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          Divider(thickness: 1, color: gray1),
          TextButton(
            child: Text(
              'Gallery',
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              controller.pickImage(source: ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          Divider(thickness: 1, color: gray1),
          if (profileController.userProfile.value?.member?.imageUrl !=
              'https://hustle-web.cranium.id/images/members/')
            TextButton(
              child: Text(
                'Delete image',
                style: DDinExp.regular.copyWith(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Get.dialog(CustomDialog().alert("Delete photo",
                    "Are you sure you want to remove?", () {
                  Get.back();
                }, () {
                  controller.deleteImage();
                }));
              },
            ),
        ],
      ),
    );
  }
}
