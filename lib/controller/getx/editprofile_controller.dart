// import 'package:ahbas/model/editprofile/edit_profile.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class EditProfileController extends GetxController {
//   var editProfileResponse = EditProfileResponse(status: false, message: '').obs;
//   var isLoading = false.obs;
//   var error = Rx<String>('');

//   Future<void> editProfile(String authToken, String userId,String ) async {
//     isLoading.value = true;
//     try {
//       final response = await http.put(
//         Uri.parse('https://ahabs.cyenosure.in/api/user/editprofile/$userId'),

//         headers: {'Authorization': 'Bearer $authToken'},
        

//         body:
//          json.encode(),
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         editProfileResponse.value = EditProfileResponse.fromJson(responseData);
//       } else {
//         error.value = 'Profile update failed';
//       }
//     } catch (error) {
//       this.error.value = 'Network error occurred';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
