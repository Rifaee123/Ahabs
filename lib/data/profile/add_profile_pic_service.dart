import 'dart:developer';
import 'dart:io';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import MediaType

class AddProfilePicService {
  Future<Either<MainFailure, bool>> addProfilePic(File imageFile) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$addProfilePicEndpoint$userId';
      log(url);
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $authToken';

      // Use imageFile directly instead of loading an image from assets
      var multipartFile = http.MultipartFile.fromBytes(
        'profilePicture',
        imageFile.readAsBytesSync(),
        filename: 'appstore.png',
        contentType:
            MediaType('application', 'json'), // Add the correct content type
      );

      request.files.add(multipartFile);

      // final http.Response response =
      //     await http.Response.fromStream(await request.send());
      final response = await request.send();

      log("Profile ${response.statusCode.toString()}");
      log("Profile 1:${response.reasonPhrase.toString()}");
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}



// class AddProfilePicService {
//   Future<Either<MainFailure, bool>> addProfilePic(File imageFile) async {
//     try {
//       final authToken =
//           await StorageService.instance.readSecureData('AuthToken');
//       final userId = convertTokenToId(authToken!);
//       DateTime now = DateTime.now();
//       String timeStamp = now.microsecondsSinceEpoch.toString();

//       final url = '$kBaseUrl$addProfilePicEndpoint$userId';
//       log(url);

//       final uri = Uri.parse(url);
//       var request = http.MultipartRequest('PUT', uri);
//       request.headers['Authorization'] = 'Bearer $authToken';
//       String filePath = await getTemporaryDirectory().then((dir) {
//         return '${dir.path}/appstore.png';
//       });
//       ByteData data = await rootBundle.load('assets/appstore.png');
//       Uint8List uint8list = data.buffer.asUint8List();
//       var multipartFile = http.MultipartFile.fromBytes(
//           'profilePicture', uint8list,
//           filename: 'appstore.png');
//       // request.files.add(
//       //     await http.MultipartFile.fromPath('profilePicture', filePath));
//       request.files.add(multipartFile);
//       log(imageFile.path);
//       // var imageStream = http.ByteStream(imageFile.openRead());
//       // var length = await imageFile.length();
//       // var multipartFile = http.MultipartFile('profilePicture', imageStream, length,
//       //     filename: '$userId$timeStamp.png');

//       // request.files.add(multipartFile);
//       var response = await request.send();

//       log("Profile ${response.statusCode.toString()}");
//       log("Profile 1:${response.reasonPhrase.toString()}");
//       if (response.statusCode == 200) {
//         return const Right(true);
//       } else {
//         return Left(MainFailure.serverFailure());
//       }
//     } catch (e) {
//       return Left(MainFailure.clientFailure());
//     }
//   }
// }

// Future<File> getImageFileFromAssets(String path) async {
//   final byteData = await rootBundle.load('assets/$path');

//   final file = File('${(await getTemporaryDirectory()).path}/$path');
//   await file.create(recursive: true);
//   await file.writeAsBytes(byteData.buffer
//       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

//   return file;
// }

// Future<File> convertAssetImageToFile(String assetName) async {
//   // Load the asset as a ByteData
//   final ByteData data = await rootBundle.load(assetName);
//   // Get the data as a Uint8List
//   final Uint8List uint8List = data.buffer.asUint8List();

//   // Get the application document directory
//   final Directory appDocDir = await getApplicationDocumentsDirectory();
//   // Define the file path
//   final String filePath = '${appDocDir.path}/$assetName';

//   // Write the data to the file
//   File file = File(filePath);
//   await file.writeAsBytes(uint8List);

//   return file;
// }

// Future<void> uploadProfilePicture(File imageFile) async {
// var request = http.MultipartRequest(
//   'POST',
//   Uri.parse('your_api_endpoint_here'),
// );

//   // Add the image to the request as form-data
// var imageStream = http.ByteStream(imageFile.openRead());
// var length = await imageFile.length();

// var multipartFile = http.MultipartFile('file', imageStream, length,
//     filename: 'profile_picture.jpg');

//   request.files.add(multipartFile);

//   // Send the request
//   var response = await request.send();

//   if (response.statusCode == 200) {
//     print('Image uploaded successfully');
//   } else {
//     print('Image upload failed with status code ${response.statusCode}');
//   }
// }
// var request = http.MultipartRequest('POST', Uri.parse('https://ahabs.cyenosure.in/api/user/addprofilepicture/651fae73c4809d45d258078f'));
// request.files.add(await http.MultipartFile.fromPath('profilePicture', '/home/shahid/Pictures/download4.jpeg'));

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }
