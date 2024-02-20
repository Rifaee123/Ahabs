import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/provider/profile/edit_profile_provider.dart';
import 'package:ahbas/view/edit_profile/profilrimage_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfileScreens extends StatelessWidget {
  const EditProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    final FolloControlller controiller = Get.put(FolloControlller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                String username = usernameController.text;
                String gender = genderController.text;

                Provider.of<EditProfileProvider>(context, listen: false)
                    .editProfile(
                  email: email,
                  gender: gender,
                  username: username,
                );
              },
              child: const Text('Update Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfilePhotoScreen(
                      controiller.authToken.value,
                      controiller.currentuserid.value),
                ));
              },
              child: const Text('Update Image'),
            ),
            Consumer<EditProfileProvider>(
              builder: (context, provider, child) {
                if (provider.isProfileEditted) {
                  return const Text('Profile updated successfully');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
