import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemFilter extends StatelessWidget {
  const ItemFilter(
      {super.key,
      required this.location,
      required this.isCheck,
      required this.onChanged});

  final String location;
  final bool isCheck;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: isCheck,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: MaterialStateBorderSide.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const BorderSide(width: 1.5, color: Colors.black);
              }
              return BorderSide(width: 1.5, color: disableColor);
            }),
            activeColor: Colors.transparent,
            checkColor: Colors.black,
            onChanged: onChanged),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            location,
            textAlign: TextAlign.start,
            style: DDinExp.regular.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
