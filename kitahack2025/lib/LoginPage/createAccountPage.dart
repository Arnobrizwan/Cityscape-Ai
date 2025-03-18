import 'package:flutter/material.dart';
import 'package:kitahack2025/LoginPage/accessPage.dart';
import 'package:kitahack2025/LoginPage/authentication.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() =>
      _CreateAccountPageState();
}

class _CreateAccountPageState
    extends State<CreateAccountPage> {
  final AuthService _authService = AuthService();
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController rePasswordController =
      TextEditingController();
  bool tick = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Join us and explore the future of urban living!',
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
                  // Name input field
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
                            PhosphorIconsRegular.user,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText:
                                  "Enter your full name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType:
                                TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
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
                              hintText: "Create a password",
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
                  // Re-password input field
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
                            controller:
                                rePasswordController,
                            decoration: InputDecoration(
                              hintText:
                                  "Re-enter your password",
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                tick = !tick;
                              }),
                            },
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: tick ? 0.5 : 1,
                            ),
                            color:
                                tick
                                    ? Colors.amber
                                    : Colors.white,
                          ),
                          child:
                              tick
                                  ? PhosphorIcon(
                                    PhosphorIconsBold.check,

                                    color: Colors.white,
                                    size: 11,
                                  )
                                  : SizedBox(),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'I agree with Terms & Conditions',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: GestureDetector(
                      onTap:
                          () => {
                            if (passwordController.text !=
                                rePasswordController.text)
                              {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Password Not Match!",
                                    ),
                                    backgroundColor:
                                        Colors.red,
                                  ),
                                ),
                              }
                            else if (!tick)
                              {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Didn't tick the Terms & Conditions",
                                    ),
                                    backgroundColor:
                                        Colors.red,
                                  ),
                                ),
                              }
                            else
                              {
                                _authService
                                    .authenticateNew(
                                      context: context,
                                      name:
                                          nameController
                                              .text,
                                      email:
                                          emailController
                                              .text,
                                      password:
                                          passwordController
                                              .text,
                                    ),
                              },
                          },
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
                            child: Text(
                              'Sign Up',
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text('Already registered?'),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const AccessPage(),
                                ),
                              ),
                            },
                        child: Text(
                          'Log in',
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
