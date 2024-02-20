import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class Authcontrolller extends GetxController {
  var registerCurrentIndex = 0.obs;
  var loginCurrentIndex = 0.obs;
  var isLogin = false.obs;
  var authToken = ''.obs;
  var isRegister = false.obs;
  late socketio.Socket streamSocket;
}
