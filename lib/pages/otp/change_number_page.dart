import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/change_number_controller.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/phone_number_text_field.dart';
import '../../utils/widgets/primary_button.dart';

class ChangeNumberPage extends StatelessWidget {
  ChangeNumberPage({super.key});

  final ChangeNumberController controller = Get.put(ChangeNumberController());
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 36,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          )),
      body: GetBuilder<ChangeNumberController>(builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Enter Mobile Number',
                style: DDinExp.black.copyWith(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Enter the mobile number to receive the OTP code via WhatsApp.',
                textAlign: TextAlign.center,
                style:
                    DDinExp.regular.copyWith(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: PhoneNumberTextField(
                  number: controller.number,
                  controller: phoneController,
                  isHideStar: true,
                  onPhoneChanged: (value) {
                    controller
                        .updateButton((value?.phoneNumber?.length ?? 0) < 12);
                    controller.dialCode = value?.dialCode ?? '+62';
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: controller.isLoading.isFalse,
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
                child: PrimaryButton(
                  text: 'Verify',
                  elevation: 0,
                  isDisable: controller.isDisableButton.value,
                  onPressed: () {
                    controller.changeNumber(phoneController.text);
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
