import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/register/pop_up_tnc.dart';
import 'package:hustle_house_flutter/pages/register/register_controller.dart';
import 'package:hustle_house_flutter/pages/register/register_type.dart';
import 'package:hustle_house_flutter/utils/widgets/date_birth_text_field.dart';
import 'package:hustle_house_flutter/utils/widgets/phone_number_text_field.dart';

import '../../utils/colors.dart';
import '../../utils/typography/d_din_exp.dart';
import '../../utils/widgets/custom_text_form_field.dart';
import '../../utils/widgets/primary_button.dart';

class RegisterStep2Page extends StatelessWidget {
  final Map<String, String>? accountSocialMedia;
  final RegisterType registerType;

  RegisterStep2Page(
      {super.key, required this.registerType, this.accountSocialMedia});

  final _formKey = GlobalKey<FormState>();

  final RegisterController controller = Get.put(RegisterController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController referrerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = accountSocialMedia?['firstName'] ?? '';
    lastNameController.text = accountSocialMedia?['lastName'] ?? '';
    double height = Get.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetBuilder<RegisterController>(builder: (_) {
        return SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            height: height < 700 ? height + 100 : height + 200,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: -40,
                  child: SvgPicture.asset("assets/images/bg_login_top.svg"),
                ),
                Positioned(
                    left: 0,
                    top: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left_outlined,
                        size: 36,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Get.back();
                      },
                    )),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 56,
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: DDinExp.bold.copyWith(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  right: 14,
                  top: 130,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: 'First Name',
                          hintText: 'Enter first name',
                          controller: firstNameController,
                          isRequired: true,
                          isDisableError: true,
                          onChanged: (value) {
                            controller.changeStateSecondReg(
                                _formKey.currentState?.validate() ?? false);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            labelText: 'Last Name',
                            hintText: 'Enter last name',
                            controller: lastNameController,
                            isRequired: true,
                            isDisableError: true,
                            onChanged: (value) {
                              controller.changeStateSecondReg(
                                  _formKey.currentState?.validate() ?? false);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        PhoneNumberTextField(
                          number: controller.number,
                          controller: phoneController,
                          onPhoneChanged: (value) {
                            controller.changeStateSecondReg(
                                (value?.phoneNumber?.length ?? 0) < 12
                                    ? false
                                    : _formKey.currentState?.validate() ??
                                        false);
                            controller.dialCode =  value?.dialCode ?? '+62';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DateBirthTextField(
                          day: controller.day?.value,
                          month: controller.month.value,
                          year: controller.year.value,
                          isError: controller.day?.value.isEmpty,
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: primaryColor,
                                        onPrimary: Colors.black,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: primaryDarkColor2,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: DateTime(2000, 1),
                                firstDate: DateTime(1965, 1),
                                lastDate: DateTime(2025));

                            controller.getPicked(picked);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          labelText: 'Referral Code',
                          hintText: 'Enter referral code',
                          controller: referrerController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _sendUpdate(),
                        const SizedBox(
                          height: 14,
                        ),
                        _termAndCondition(),
                        const SizedBox(
                          height: 34,
                        ),
                        Visibility(
                          visible: controller.isLoadingStep2.isFalse,
                          child: PrimaryButton(
                            text: 'Sign Up',
                            isDisable: controller.isDisable(),
                            onPressed: () {
                              switch (registerType) {
                                case RegisterType.normal:
                                  controller.register(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: '${controller.dialCode}${phoneController.text}',
                                      referrer: referrerController.text);
                                  break;
                                case RegisterType.google:
                                  controller.registerSocialMedia(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: '${controller.dialCode}${phoneController.text}',
                                      referrer: referrerController.text,
                                      registerType: registerType);
                                  break;
                                case RegisterType.facebook:
                                  controller.registerSocialMedia(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: '${controller.dialCode}${phoneController.text}',
                                      referrer: referrerController.text,
                                      registerType: registerType);
                                  break;
                                case RegisterType.apple:
                                  controller.registerSocialMedia(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: '${controller.dialCode}${phoneController.text}',
                                      referrer: referrerController.text,
                                      registerType: registerType);
                                  break;

                                default:
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: controller.isLoadingStep2.isTrue,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }

  Widget _termAndCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: controller.isCheckTnC.value,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                side: MaterialStateBorderSide.resolveWith((states) =>
                    const BorderSide(width: 1.5, color: Colors.black)),
                activeColor: Colors.transparent,
                checkColor: Colors.black,
                onChanged: (value) {
                  controller.changeIsCheckTnC();
                }),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.dialog(PopUpTnC());
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'I agree to Hustle\'s ',
                        style: DDinExp.regular.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Service & Privacy Policy.',
                        style: DDinExp.bold.copyWith(
                          color: blue,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _sendUpdate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: controller.isCheckUpdate.value,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: Colors.black)),
            activeColor: Colors.transparent,
            checkColor: Colors.black,
            onChanged: (value) {
              controller.changeIsCheckUpdate();
            }),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Text(
            'I agree to receiving updates and information from Hustle related to their products, services, and events.',
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
