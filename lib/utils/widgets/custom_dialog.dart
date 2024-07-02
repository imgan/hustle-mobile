import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../colors.dart';

class CustomDialog {
  success(String message, VoidCallback onTap) {
    final height = Get.height < 800 ? Get.height / 3 : Get.height / 3.5;
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ic_success.svg"),
            const SizedBox(
              height: 16,
            ),
            Text(
              message,
              style: DDinExp.black.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            // const SizedBox(
            //   height: 30,
            // )
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: PrimaryButton(
            elevation: 0,
            text: 'OK',
            onPressed: onTap,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
    return alert;
  }

  alert(String title, String subTitle, VoidCallback onCancel,
      VoidCallback onConfirm,
      {String? message = ""}) {
    double verticalValue() {
      double height = Get.height;
      String isMessage = message ?? "";

      if (Platform.isIOS) {
        if (height < 900) {
          if (isMessage.isNotEmpty) {
            return height / 3.9;
          } else {
            return height / 3.6;
          }
        } else {
          if (isMessage.isNotEmpty) {
            return height / 3.5;
          } else {
            return height / 3.2;
          }
        }
      }

      if (height < 900) {
        if (isMessage.isNotEmpty) {
          return height / 3.6;
        } else {
          return height / 3.3;
        }
      } else {
        if (isMessage.isNotEmpty) {
          return height / 3.2;
        } else {
          return height / 2.9;
        }
      }
    }

    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      insetPadding:
          EdgeInsets.symmetric(horizontal: 20, vertical: verticalValue()),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            SvgPicture.asset("assets/images/ic_alert_popup.svg"),
            const SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: DDinExp.black.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Text(
              subTitle,
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (message!.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  textAlign: TextAlign.center,
                  message,
                  style: DDinExp.bold.copyWith(
                    color: const Color(0xFFFF2E12),
                    fontSize: 16,
                  ),
                ),
              )
          ],
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PrimaryButton(
                    borderSideColor: Colors.black,
                    colorButton: Colors.white,
                    elevation: 0,
                    text: 'No',
                    onPressed: onCancel),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryButton(
                  text: 'Yes',
                  textColor: message.isNotEmpty ? Colors.white : Colors.black,
                  colorButton: message.isNotEmpty
                      ? const Color(0xFFFF2E12)
                      : primaryColor,
                  borderSideColor: message.isNotEmpty ? red : primaryColor,
                  isDisable: false,
                  onPressed: onConfirm,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
    return alert;
  }

  rating({String? message = "", Function(double, String)? rate}) {
    TextEditingController controller = TextEditingController();
    double myRating = 0;
    AlertDialog rating = AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Rate Your Visit",
                style: DDinExp.black.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Tell us how we're doing!",
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RatingBar(
                itemSize: 40,
                initialRating: myRating,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: false,
                tapOnlyMode: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: gold,
                  ),
                  half: Icon(Icons.star_half, color: gold),
                  empty: Icon(Icons.star_border, color: gold),
                ),
                onRatingUpdate: (rating) {
                  myRating = rating;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height / 7.5,
                width: Get.width,
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    left: 14, right: 14, bottom: 1, top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(width: 1, color: disableColor),
                      top: BorderSide(width: 1, color: disableColor),
                      right: BorderSide(width: 1, color: disableColor),
                      bottom: BorderSide(width: 1, color: disableColor),
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Write your review here',
                    hintStyle: DDinExp.regular.copyWith(
                      color: gray2,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Visibility(
                  visible: message!.isNotEmpty,
                  child: Text(
                    textAlign: TextAlign.center,
                    message,
                    style: DDinExp.bold.copyWith(
                      color: const Color(0xFFFF2E12),
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PrimaryButton(
                    borderSideColor: Colors.black,
                    colorButton: Colors.white,
                    elevation: 0,
                    text: 'Cancel',
                    onPressed: () {
                      Get.back();
                    }),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryButton(
                    text: 'Submit',
                    textColor: Colors.black,
                    colorButton: primaryColor,
                    borderSideColor: primaryColor,
                    isDisable: false,
                    onPressed: () {
                      rate!(myRating, controller.text);
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
    return rating;
  }

  loading() {
    double vertical = Get.height < 800 ? 200 : 280;
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 50, vertical: vertical),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        height: 120,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                'Processing',
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
    return alert;
  }
}
