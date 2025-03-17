import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitahack2025/homePage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> authenticate({
    required BuildContext context,
    required String email,
    required String password,
    required bool isLogin,
  }) async {
    try {
      if (isLogin) {
        // Login user
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // Sign up user
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success! You are logged in."),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
