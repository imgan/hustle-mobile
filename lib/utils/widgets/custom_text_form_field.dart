import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool? isObscure;
  final bool? isPassword;
  final bool? isRequired;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool? isDisableError;
  final AutovalidateMode? autoValidateMode;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.isObscure,
      this.isPassword,
      this.isRequired,
      this.controller,
      this.validator,
      this.onChanged,
      this.isDisableError,
      this.autoValidateMode});

  @override
  CustomTextFormFieldState createState() {
    return CustomTextFormFieldState();
  }
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: widget.labelText,
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              )),
          TextSpan(
              text: widget.isRequired ?? false ? ' *' : '',
              style: DDinExp.bold.copyWith(
                color: red,
                fontSize: 14,
              ))
        ])),
        TextFormField(
          autovalidateMode: widget.autoValidateMode,
          onChanged: widget.onChanged,
          cursorColor: primaryDarkColor,
          controller: widget.controller,
          obscureText: widget.isObscure ?? false ? passwordVisibility : false,
          validator: widget.validator,
          textCapitalization: TextCapitalization.sentences,
          style: DDinExp.regular.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),

              errorStyle: DDinExp.regular.copyWith(
                color: widget.isDisableError ?? false ? primaryColor : red,
                fontSize: 14,
              ),
              hintText: widget.hintText,
              hintStyle: DDinExp.regular.copyWith(
                color: gray,
                fontSize: 14,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),
              suffixIcon: widget.isPassword ?? false
                  ? IconButton(
                      icon: Icon(
                        passwordVisibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                    )
                  : null),
        )
      ],
    );
  }
}
