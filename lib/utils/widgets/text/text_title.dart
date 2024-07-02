import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: DDinExp.extraBold.copyWith(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
