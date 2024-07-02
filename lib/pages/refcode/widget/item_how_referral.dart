import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/ref_how_to_work.dart';

import '../../../utils/colors.dart';
import '../../../utils/typography/d_din_exp.dart';

class ItemHowReferral extends StatelessWidget {
  const ItemHowReferral({super.key, required this.refHowToWork});

  final RefHowToWork refHowToWork;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: SvgPicture.asset(refHowToWork.image)),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      refHowToWork.description,
                      style: DDinExp.regular.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !(refHowToWork.isHideDivider ?? false),
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 24,
                    child: VerticalDivider(
                      color: disableColor,
                      thickness: 1.5,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
