import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

class NotifySection extends StatelessWidget {
  const NotifySection({super.key, this.onTap, this.isNotify, this.isLoading});

  final VoidCallback? onTap;
  final bool? isNotify;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: gray1,
            blurRadius: 10,
            offset: const Offset(0, -3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              child: Text(
                isNotify ?? false
                    ? 'Get notified when a spot becomes available.'
                    : 'Get notified when a spot becomes available.',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onTap,
            child: _notify(),
          ),
        ],
      ),
    );
  }

  Widget _notify() {
    if (isLoading ?? false) {
      return const Loading(
        width: 108,
        height: 40,
      );
    }
    if (isNotify ?? false) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Notify me',
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              "assets/images/ic_notification.svg",
              width: 20,
              height: 20,
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: gray1),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: SvgPicture.asset(
        "assets/images/ic_active_notification.svg",
        width: 20,
        height: 20,
      ),
    );
  }
}
