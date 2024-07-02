import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../utils/colors.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome(
      {super.key,
      required this.onChanged,
      required this.controller,
      this.onCancel,
      this.isShowCancel});

  final Function(String) onChanged;
  final TextEditingController controller;
  final VoidCallback? onCancel;
  final bool? isShowCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ]),
      child: TextField(
        autofocus: true,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: 'Search something',
            hintStyle: DDinExp.regular.copyWith(
              color: gray2,
              fontSize: 14,
            ),
            prefixIcon: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ),
            suffixIcon: Visibility(
              visible: isShowCancel ?? false,
              child: InkWell(
                onTap: onCancel,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}
