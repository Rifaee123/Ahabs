import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/view/auth_page/auth_page.dart';
import 'package:ahbas/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> readAuthToken() async {
    bool? authToken;
    try {
      authToken =
          await StorageService.instance.containsKeyInSecureData('AuthToken');
      // Use the authToken for your authentication logic.
      print('Authentication Token: $authToken');
    } catch (e) {
      print('Error reading authentication token: $e');
    }
    return authToken!;
  }

  bool? authToken;

  void initState() {
    super.initState();

    // Simulate a time-consuming operation, such as initializing some data
    Future.delayed(Duration(seconds: 3), () async {
      authToken = await readAuthToken();
       final authorizationToken =
          await StorageService.instance.readSecureData('AuthToken');
      // Navigate to the next screen after the splash screen
      print(authToken);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => authToken == true ? HomePage(authorizationToken: authorizationToken!,) : AuthPage(),
      )); // Replace '/home' with your home screen route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150.h,
          child: Image.asset('assets/images/ahabsLogo.png'),
        ), // Path to your splash screen image
      ),
    );
  }
}
