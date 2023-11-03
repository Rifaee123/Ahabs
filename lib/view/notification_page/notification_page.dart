import 'package:ahbas/controller/getx/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationsController _notificationsController = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Obx(() {
          if (_notificationsController.isLoading.value) {
            return CircularProgressIndicator();
          } else if (_notificationsController.error.value.isNotEmpty) {
            return Text(_notificationsController.error.value);
          } else if (_notificationsController.notifications.isEmpty) {
            return Text('No notifications');
          } else {
            return ListView.builder(
              itemCount: _notificationsController.notifications.length,
              itemBuilder: (context, index) {
                var notification = _notificationsController.notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    // backgroundImage: NetworkImage(notification.user.profilePicture),
                  ),
                  title: Text(notification.user.username),
                  subtitle: Text(notification.content),
                  onTap: () {
                    // Handle notification tap
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}
