import 'dart:developer';

import 'package:ahbas/controller/getx/notification_controller.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/model/notification/notification_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as socketio;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.streamSocket});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
  final socketio.Socket streamSocket;
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());
  NotificationStream notificationStream = NotificationStream();
  @override
  void initState() {
    SocketIoService.instance
        .getFollowNotification(notificationStream, widget.streamSocket);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder(
          stream: notificationStream.getfollowResponse,
          builder: (context, snapshot) {
            log('okaydei');
            return Center(
              child: Obx(() {
                if (_notificationsController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (_notificationsController.error.value.isNotEmpty) {
                  return Text(_notificationsController.error.value);
                } else if (_notificationsController.notifications.isEmpty) {
                  return const Text('No notifications');
                }
                 else {
                  final notificationList =
                      _notificationsController.notifications;
                  log('Hurrayyyy');
                  if (snapshot.data != null) {
                    log('Hurrayyyy');
                    final notification = snapshot.data;
                    _notificationsController.notifications.add(
                        Notifications(
                            id: notification['sender_id'],
                            receiver: notification['receiver'],
                            user: User(
                                id: notification['sender_id'],
                                username: notification['username'],
                                profilePicture: notification['profilepicture']),
                            content: notification['content'],
                            isRead: false,
                            createdAt:
                                DateTime.parse(notification['createdAt']),
                            updatedAt: DateTime.now()));

                    notificationList.add(Notifications(
                        id: notification['sender_id'],
                        receiver: notification['receiver'],
                        user: User(
                            id: notification['sender_id'],
                            username: notification['username'],
                            profilePicture: notification['profilepicture']),
                        content: notification['content'],
                        isRead: false,
                        createdAt: DateTime.parse(notification['createdAt']),
                        updatedAt: DateTime.now()));
                  }
                  return ListView.builder(
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      var notification = notificationList[index];
                      return ListTile(
                        leading: const CircleAvatar(
                            // backgroundImage: NetworkImage(notification.user.profilePicture),
                            ),
                        title: Text(notification.user.username.toString()),
                        subtitle: Text(notification.content),
                        onTap: () {
                          // Handle notification tap
                        },
                      );
                    },
                  );
                }
              }),
            );
          }),
    );
  }
}
