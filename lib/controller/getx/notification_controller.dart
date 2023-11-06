import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/notification/notification_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class NotificationsController extends GetxController {
  var notifications = <Notification>[].obs;
  var isLoading = false.obs;
  var error = Rx<String>('');

  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    socket = IO.io('https://ahabs.cyenosure.in', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('notification', (data) {
      var notification = Notification.fromJson(data);
      notifications.insert(
          0, notification); // Add new notification to the beginning of the list
    });
  }

  Future<void> fetchNotifications() async {
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
            'https://ahabs.cyenosure.in/api/notification/getnotification'),
        headers: {'Authorization': 'Bearer $authToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        notifications.value = responseData
            .map((data) => Notification.fromJson(data))
            .toList()
            .reversed
            .toList();
      } else {
        error.value = 'Failed to load notifications';
      }
    } catch (error) {
      this.error.value = 'Network error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}


// class NotificationsController extends GetxController {
//   var notifications = <Notification>[].obs;
//   var isLoading = false.obs;
//   var error = Rx<String>('');

//   Future<void> fetchNotifications() async {
//     final authToken = await StorageService.instance.readSecureData('AuthToken');
//     isLoading.value = true;
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://ahabs.cyenosure.in/api/notification/getnotification'),
//         headers: {'Authorization': 'Bearer $authToken'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body)['data'];
        // notifications.value = responseData
        //     .map((data) => Notification.fromJson(data))
        //     .toList()
        //     .reversed
        //     .toList();
//       } else {
//         error.value = 'Failed to load notifications';
//       }
//     } catch (error) {
//       this.error.value = 'Network error occurred';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

