import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../profile/profile_controller.dart';
import '../colors.dart';

class DateBirthEditTextField extends StatelessWidget {
  final void Function() onPressed;
  final String? day;
  final String? month;
  final String? year;
  final bool? isError;

  final ProfileController profileController = Get.find<ProfileController>();

  DateBirthEditTextField(
      {super.key,
      required this.onPressed,
      this.day,
      this.month,
      this.year,
      this.isError});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Date of Birth',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              )),
        ])),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getDay(),
                      style: DDinExp.regular.copyWith(
                        color: day == null || (day?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getMonth(),
                      style: DDinExp.regular.copyWith(
                        color: month == null || (month?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getYear(),
                      style: DDinExp.regular.copyWith(
                        color: year == null || (year?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String getDay() {
    if (day == null || (day?.isEmpty ?? false)) {
      if (profileController.userProfile.value?.member?.dateOfBirth?.year ==
          -1) {
        return 'DD';
      }
      return profileController.userProfile.value?.member?.dateOfBirth?.day
              .toString() ??
          'DD';
    }
    return day ?? 'DD';
  }

  String getMonth() {
    if (month == null || (month?.isEmpty ?? false)) {
      if (profileController.userProfile.value?.member?.dateOfBirth?.year ==
          -1) {
        return 'MM';
      }
      return profileController.userProfile.value?.member?.dateOfBirth?.month
              .toString() ??
          'MM';
    }
    return month ?? 'MM';
  }

  String getYear() {
    if (year == null || (year?.isEmpty ?? false)) {
      if (profileController.userProfile.value?.member?.dateOfBirth?.year ==
          -1) {
        return 'YY';
      }
      return profileController.userProfile.value?.member?.dateOfBirth?.year
              .toString() ??
          'YY';
    }
    return year ?? 'YY';
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
