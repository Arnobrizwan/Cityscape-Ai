import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kitahack2025/Extra/homePage.dart';
import 'package:kitahack2025/LoginPage/authentication.dart';
import 'package:kitahack2025/LoginPage/firstPage.dart';
import 'package:kitahack2025/bottomNavigation.dart';
import "firebase_options.dart";
import 'dart:ui' as ui;

void main() async {
  // Tell Flutter to load all dependencies when start loading Flutter
  WidgetsFlutterBinding.ensureInitialized();
    // ui.debugDisableImpeller = true;
  // Wait Firebase to initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();

    return MaterialApp(
      title: 'KitaHack2025',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      // home: BottomNaivgation(),
      home: FutureBuilder<bool>(
        future: _authService.autoLogin(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ), // Show a loading indicator
            );
          } else if (snapshot.hasData &&
              snapshot.data == true) {
            return BottomNaivgation(); // Navigate to home if logged in
          } else {
            return FirstPage(); // Navigate to login page if not logged in
          }
        },
      ),
    );
  }
}
