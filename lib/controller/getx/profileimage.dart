import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditProfilePhotoController extends GetxController {
  var isLoading = false.obs;
  var error = Rx<String>('');

  Future<void> uploadProfilePhoto(String authToken, String userId, String imagePath) async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://ahabs.cyenosure.in/api/user/addprofilepicture/$userId'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $authToken',
      });

      request.files.add(await http.MultipartFile.fromPath('profilePicture', imagePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle success
        print('Profile photo uploaded successfully');
      } else {
        // Handle error
        error.value = 'Failed to upload profile photo';
      }
    } catch (error) {
      this.error.value = 'Network error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}
