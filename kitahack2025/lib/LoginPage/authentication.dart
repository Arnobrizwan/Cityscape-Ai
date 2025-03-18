import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitahack2025/homePage.dart';
import 'package:kitahack2025/newHomePage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> authenticateNew({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Sign up user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      // Save user details to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': name,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success! You are logged in."),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewHomePage(),
        ),
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

  Future<void> authenticateNewLogIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Login user
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success! You are logged in."),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewHomePage(),
        ),
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
