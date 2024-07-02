import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/notification/notification_controller.dart';
import 'package:hustle_house_flutter/pages/notification/widget/item_notification.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import '../../utils/colors.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final controller = Get.put(NotificationController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final notifications = controller.notifications;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.80 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMore.isTrue) {
        controller.getMoreNotification();
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Notifications',
      ),
      body: GetBuilder<NotificationController>(builder: (_) {
        if (controller.isLoading.isTrue) {
          return const ListLoading(
            itemCount: 10,
          );
        }
        if (notifications.isEmpty) {
          return const EmptyClass(
            text: 'No notifications',
          );
        }
        return ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final notification = notifications[index];
              return InkWell(
                onTap: () {
                  controller.onTapAction(
                      key: notification.notifType ?? '',
                      sessionId: notification.sessionID,
                      sportClassId: notification.sportsClassId,
                      category: notification.category,
                      description: notification.description);
                },
                child: Column(
                  children: [
                    ItemNotification(notification: notification),
                    Divider(thickness: 1, color: gray1)
                  ],
                ),
              );
            },
            itemCount: notifications.length);
      }),
    );
  }
}
