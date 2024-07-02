import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/typography/d_din_exp.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.onCancel,
      this.isShowCancel});

  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onCancel;
  final bool? isShowCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: 34,
          child: TextField(
            autofocus: true,
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChanged,
            cursorColor: primaryDarkColor,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
                hintStyle: DDinExp.regular.copyWith(
                  color: gray2,
                  fontSize: 14,
                ),
                prefixIcon: InkWell(
                  child: Icon(
                    Icons.search_rounded,
                    size: 18,
                    color: gray2,
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
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.white),
          ),
        ),
        Divider(
          color: gray2,
        )
      ],
    );
  }
}
