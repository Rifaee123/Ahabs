import 'dart:convert';

import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/group/group_create.dart';
import 'package:ahbas/model/group/group_create_to_json.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GroupController extends GetxController {
  var isLoading = false.obs;

  Future<void> createGroup(GroupCreate group) async {
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    try {
      isLoading.value = true;

      var uri = Uri.parse('https://ahabs.cyenosure.in/api/group/creategroup');
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers['Authorization'] = authToken!;

      // Add fields
      request.fields['name'] = group.name;
      request.fields['description'] = group.description;
      request.fields['participants'] = jsonEncode(group.participants);

      // Add image file if available
      var stream = http.ByteStream(group.image.openRead());
      var length = await group.image.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: group.image.path.split('/').last);
      request.files.add(multipartFile);
    
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body)['data'];
        var createdGroup = Group.fromJson(responseData);
        // Handle the created group as needed
        print('Group created successfully: $createdGroup');
      } else {
        Get.snackbar('Error', 'Failed to create group');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
