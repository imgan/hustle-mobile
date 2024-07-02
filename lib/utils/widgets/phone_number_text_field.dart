import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../colors.dart';

class PhoneNumberTextField extends StatelessWidget {
  final PhoneNumber? number;
  final Function(PhoneNumber?)? onPhoneChanged;
  final TextEditingController? controller;
  final bool? isHideStar;

  const PhoneNumberTextField(
      {super.key,
      this.number,
      this.onPhoneChanged,
      this.controller,
      this.isHideStar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Mobile Number',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              )),
          TextSpan(
              text: (isHideStar ?? false) ? '' : ' *',
              style: DDinExp.bold.copyWith(
                color: red,
                fontSize: 14,
              ))
        ])),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Colors.black.withOpacity(0.8)))),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                top: 10,
                left: 0,
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Row(
                    children: [
                      Spacer(),
                      Icon(
                        CupertinoIcons.chevron_down,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
                child: InternationalPhoneNumberInput(
                  validator: (value) {
                    if (value?.isEmpty ?? false || value == null) {
                      return '';
                    }
                    return null;
                  },
                  onInputChanged: onPhoneChanged,
                  onInputValidated: (bool value) {},
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.always,
                  selectorTextStyle: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: false,
                    leadingPadding: 10,
                    showFlags: false,
                    trailingSpace: true,
                  ),
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                      hintText: 'Enter your phone number',
                      hintStyle: DDinExp.regular.copyWith(
                        color: gray,
                        fontSize: 14,
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      errorStyle: (TextStyle(height: 0, color: primaryColor))),
                  textStyle: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  onSaved: (PhoneNumber number) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
