import 'package:ahbas/provider/login/login_provider.dart';
import 'package:ahbas/provider/register/email_registration_provider.dart';
import 'package:ahbas/provider/register/phone_registration_provider.dart';
import 'package:ahbas/provider/verify_email/verify_email_provider.dart';
import 'package:ahbas/view/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PhoneRegistrationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => EmailRegistrationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => VerifyEmailProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xff449cc0)),
              useMaterial3: true,
            ),
            home: const AuthPage()),
      ),
    );
  }
}
