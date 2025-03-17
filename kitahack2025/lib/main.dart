import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kitahack2025/googleMapPage.dart';
import 'package:kitahack2025/homePage.dart';
import 'package:kitahack2025/loginPage.dart';
import "firebase_options.dart";

void main() async {
  // Tell Flutter to load all dependencies when start loading Flutter
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'KitaHack2025',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: GoogleMapPage(),
    );
  }
}
