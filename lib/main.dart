import 'package:bonjour/pages/home_page.dart';
import 'package:bonjour/pages/welcome_page.dart';
import 'package:bonjour/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bonjour/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAx5wajiBrTZ3mf4Ky9LAK02ZXhW2aNqno",
          appId: "1:55270415637:android:40afe1e113af52c1bd9d1c",
          messagingSenderId: "55270415637",
          projectId: "chat-app-37c31")).then((value)=> Get.put(AuthService()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: Scaffold(
        body: WelcomePage(),
      ),
    );
  }
}

