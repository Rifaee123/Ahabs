import 'dart:io';

import 'package:ahbas/controller/getx/profileimage.dart';
import 'package:ahbas/provider/profile/add_profile_pic_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePhotoScreen extends StatefulWidget {
  final String authToken;
  final String userId;

  const EditProfilePhotoScreen(this.authToken, this.userId, {super.key});

  @override
  State<EditProfilePhotoScreen> createState() => _EditProfilePhotoScreenState();
}

class _EditProfilePhotoScreenState extends State<EditProfilePhotoScreen> {
  final EditProfilePhotoController _editProfilePhotoController =
      Get.put(EditProfilePhotoController());

  XFile? _imageFile;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource
            .gallery, // You can also use ImageSource.camera for taking a picture
      );

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImage(File imagePath) async {
    Provider.of<AddProfilePicProvider>(context, listen: false)
        .updateImage(profilePic: imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey,
              child: _imageFile == null
                  ? const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    )
                  : ClipOval(
                      child: Image.file(
                      File(_imageFile!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Profile Photo'),
            ),
            _imageFile != null
                ? ElevatedButton(
                    onPressed: () async {
                      await uploadImage(File(_imageFile!.path));
                    },
                    child: const Text('upload'),
                  )
                : const SizedBox.shrink(),
            Consumer<AddProfilePicProvider>(
              builder: (context, value, child) {
                if (value.isAddedProfilePic == true) {
                  return const Text("profile pic updated");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
