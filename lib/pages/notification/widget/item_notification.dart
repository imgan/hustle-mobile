import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/notification.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/ic_calendar_available.svg",
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.name ?? '',
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  notification.description ?? '',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
