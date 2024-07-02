import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../typography/d_din_exp.dart';

class TextUrl extends StatelessWidget {
  const TextUrl({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    String httpsPrefix = "https://";
    int startIndex = 0;

    while (startIndex < text.length) {
      int httpsIndex = text.indexOf(httpsPrefix, startIndex);
      if (httpsIndex == -1) {
        textSpans.add(TextSpan(text: text.substring(startIndex)));
        break;
      }

      textSpans.add(TextSpan(text: text.substring(startIndex, httpsIndex)));

      int endIndex = text.indexOf(" ", httpsIndex);
      if (endIndex == -1) {
        endIndex = text.length;
      }

      textSpans.add(TextSpan(
        text: text.substring(httpsIndex, endIndex),
        style: DDinExp.regular.copyWith(fontSize: 14, color: blue),
      ));

      startIndex = endIndex;
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: DDinExp.regular
            .copyWith(fontSize: 14, color: Colors.black)
      ),
    );
  }
}
