import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../../utils/colors.dart';

class SearchDiscount extends StatelessWidget {
  const SearchDiscount(
      {super.key,
      this.controller,
      this.onCancel,
      this.onTap,
      this.isDisable,
      required this.onChanged});

  final Function(String) onChanged;
  final TextEditingController? controller;
  final VoidCallback? onCancel;
  final VoidCallback? onTap;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            cursorColor: primaryDarkColor,
            decoration: InputDecoration(
                hintText: 'Enter discount code',
                hintStyle: DDinExp.regular.copyWith(
                  color: gray2,
                  fontSize: 14,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                suffixIcon: InkWell(
                  onTap: onCancel,
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: disableColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: disableColor),
                ),
                filled: true,
                fillColor: Colors.white),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            flex: 1,
            child: PrimaryButton(
              borderRadiusSize: 10,
              colorButton: (isDisable ?? false) ? disableColor : primaryColor,
              borderSideColor:
                  (isDisable ?? false) ? disableColor : primaryColor,
              elevation: 0,
              text: 'Search',
              onPressed: (isDisable ?? false) ? null : onTap,
            ))
      ],
    );
  }
}
