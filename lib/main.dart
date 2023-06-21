import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techsolution/splashscreen.dart';
import 'package:techsolution/view/login.dart';
import 'package:techsolution/view/home.dart';
import 'package:techsolution/view/notification.dart';
import 'package:techsolution/view/message.dart';
import 'package:techsolution/widget/edit_profile.dart';
import 'package:techsolution/view/profile.dart';
import 'package:techsolution/widget/assist/detail_notification.dart';
import 'package:techsolution/widget/assist/detail_chat.dart';
import 'package:techsolution/widget/assist/hint_point.dart';
import 'package:techsolution/widget/absence.dart';
import 'package:techsolution/widget/assist/detail_absence.dart';

void main(context) {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/notification': (context) => const NotificationPage(),
        '/message': (context) => const MessagePage(),
        '/detail-chat': (context) => const DetailChatPage(),
        '/detail-notif': (context) => const DetailNotifPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditPorfilePage(),
        '/hint-point': (context) => const HintPointPage(),
        '/absen-page': (context) => const AbsencePage(),
        '/detail-absence': (context) => const DetailAbsenPage(),
      },
    );
  }
}
