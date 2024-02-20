// import 'dart:convert';
// import 'dart:developer';
// import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
// import 'package:ahbas/model/group/group_create.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class GroupService extends GetxService {
//   final String baseUrl = 'https://ahabs.cyenosure.in/api/group';

//   Future<Group> createGroup(String name, String description) async {
//     final authToken = await StorageService.instance.readSecureData('AuthToken');
//     log('Auther${authToken.toString()}');
//     final response = await http.post(
//       Uri.parse('$baseUrl/creategroup'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': authToken!,
//       },
//       body: jsonEncode({
//         'name': name,
//         'description': description,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       return Group.fromJson(responseData);
//     } else {
//       throw Exception('Failed to create group: ${response.reasonPhrase}');
//     }
//   }
// }
