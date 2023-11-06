
import 'package:ahbas/data/services/hive/chat_length/chat_length_service.dart';
import 'package:ahbas/data/services/hive/chat_length/models/chat_length.dart';


import 'package:ahbas/provider/chat/chat_provider.dart';



import 'package:ahbas/provider/folllow_following/follow_following_provider.dart';

import 'package:ahbas/provider/login/login_provider.dart';
import 'package:ahbas/provider/profile/current_user_provider.dart';
import 'package:ahbas/provider/register/email_registration_provider.dart';
import 'package:ahbas/provider/register/phone_registration_provider.dart';
import 'package:ahbas/provider/search/search_provider.dart';
import 'package:ahbas/provider/verify_email/verify_email_provider.dart';
import 'package:ahbas/provider/verify_phone/verify_phone_provider.dart';

import 'package:ahbas/view/auth_page/auth_page.dart';

import 'package:ahbas/view/home_page/home_page.dart';

import 'package:ahbas/view/splash_page/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatLengthModelAdapter());
  await Hive.openBox<ChatLengthModel>('ChatLengthBox');
  ChatLengthService.instance.openChatLengthBox();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyPhoneProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchPrvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentUserProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => FollowFollowingProvider(),

        ),
      ],
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff449cc0)),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
