import 'package:flutter/material.dart';
import 'package:kitahack2025/LoginPage/authentication.dart';
import 'package:kitahack2025/LoginPage/createAccountPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Text(
              'Access Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Access your urban insights with ease.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              // Column of the four input container
              child: Column(
                children: [
                  // Email Input Field
                  Container(
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
                                  "Your email address",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType:
                                TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  // Password input field
                  Container(
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
                            PhosphorIconsRegular.password,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText:
                                  "Enter your password",
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
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => {},
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),

                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(10),
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
                                    _authService
                                        .authenticateNewLogIn(
                                          context: context,

                                          email:
                                              emailController
                                                  .text,
                                          password:
                                              passwordController
                                                  .text,
                                        ),
                                  },
                              child: Text(
                                'Log in',
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
