import 'package:flutter/material.dart';
import 'package:kitahack2025/LoginPage/authentication.dart';
import 'package:kitahack2025/LoginPage/createAccountPage.dart';
import 'package:kitahack2025/LoginPage/verifyEmailPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Forgetpasswordpage extends StatefulWidget {
  const Forgetpasswordpage({super.key});

  @override
  State<Forgetpasswordpage> createState() =>
      _ForgetpasswordpageState();
}

class _ForgetpasswordpageState
    extends State<Forgetpasswordpage> {
  final TextEditingController emailController =
      TextEditingController();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Enter your email to receive a reset link',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: Colors.grey.shade300,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                            child: PhosphorIcon(
                              PhosphorIconsRegular.envelope,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: emailController,

                              decoration: InputDecoration(
                                hintText:
                                    "Enter your email",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              keyboardType:
                                  TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                          child: GestureDetector(
                            onTap:
                                () => {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder:
                                  //         (context) =>
                                  //             VerifyEmailPage(),
                                  //   ),
                                  // ),
                                  _authService.sendOTP(
                                    email:
                                        emailController
                                            .text,
                                    context: context,
                                  ),
                                },
                            child: Text(
                              'Send Reset Link',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text('Need to create an account?'),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          CreateAccountPage(),
                                ),
                              ),
                            },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
