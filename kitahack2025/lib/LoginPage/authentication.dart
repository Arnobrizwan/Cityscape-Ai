import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitahack2025/Extra/homePage.dart';
import 'package:kitahack2025/Extra/newHomePage.dart';
import 'package:kitahack2025/LoginPage/firstPage.dart';
import 'package:kitahack2025/LoginPage/verifyEmailPage.dart';
import 'package:kitahack2025/bottomNavigation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

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
            'password': password,
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
          builder: (context) => BottomNaivgation(),
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
          builder: (context) => BottomNaivgation(),
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

  // Logout function
  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You have been logged out."),
          backgroundColor: Colors.orange,
        ),
      );

      // Navigate back to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
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

  // Auto login: Check if a user is already signed in
  Future<bool> autoLogin(BuildContext context) async {
    if (_auth.currentUser != null) {
      // Navigate to home page if user is already logged in
      print('hi');
      return true;
    }
    print('bye');
    return false;
  }

  // Future<void> authenticate({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  //   required bool isLogin,
  // }) async {
  //   try {
  //     if (isLogin) {
  //       // Login user
  //       await _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     } else {
  //       // Sign up user
  //       await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Success! You are logged in."),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Error: ${e.toString()}"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  String generateOTP() {
    final Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<void> sendOTP({
    required email,
    required context,
  }) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an email")),
      );
      return;
    }

    try {
      String otp = generateOTP(); // Generate OTP

      try {
        // Query Firestore to find the document ID (UID) associated with the given email
        var querySnapshot =
            await _firestore
                .collection('users')
                .where('email', isEqualTo: email)
                .limit(1) // Get only one document
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Get the user UID (document ID)
          String userId = querySnapshot.docs.first.id;

          // Update the document with OTP
          await _firestore
              .collection('users')
              .doc(userId)
              .update({
                'otp': otp,
                'timestamp': FieldValue.serverTimestamp(),
              });

          print("OTP sent successfully!");
        } else {
          print("No user found with this email.");
        }
      } catch (e) {
        print("Error sending OTP: $e");
      }

      // Store OTP in Firestore
      // await _firestore.collection('users').doc(email).set({
      //   'otp': otp,
      //   'timestamp': FieldValue.serverTimestamp(),
      // });

      // await _firestore
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set({
      //       'name': name,
      //       'email': email,
      //       'password': password,
      //       'createdAt': FieldValue.serverTimestamp(),
      //     });

      print(otp);

      // Send OTP via Firebase Authentication
      await _auth.sendPasswordResetEmail(email: email);

      // Navigate to VerifyEmailPage with email
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  VerifyEmailPage(otp: otp, email: email),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP sent to $email")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Future<void> updatePassword({
    required BuildContext context,
    required String newPassword,
    required String email,
  }) async {
    if (newPassword.isEmpty || newPassword.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password must be at least 6 characters",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      try {
        var querySnapshot =
            await _firestore
                .collection('users')
                .where('email', isEqualTo: email)
                .limit(1) // Get only one document
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Get the user UID (document ID)
          String userId = querySnapshot.docs.first.id;

          var oldPassword =
              querySnapshot.docs.first['password'];

          // Update the document with OTP
          await _firestore
              .collection('users')
              .doc(userId)
              .update({
                'password': newPassword,
                'timestamp': FieldValue.serverTimestamp(),
              });

          await _auth.signInWithEmailAndPassword(
            email: email,
            password: oldPassword,
          );

          User? user = _auth.currentUser;
          if (user != null) {
            await user.updatePassword(newPassword);
          }

          print("password changed successfully!");
        } else {
          print("No eamil found for this user.");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No email found')),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password updated successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNaivgation(),
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
}
