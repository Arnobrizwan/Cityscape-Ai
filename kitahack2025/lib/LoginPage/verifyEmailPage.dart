import 'package:flutter/material.dart';
import 'package:kitahack2025/LoginPage/createAccountPage.dart';
import 'package:kitahack2025/LoginPage/resetPasswordPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class VerifyEmailPage extends StatefulWidget {
  final String otp;
  final String email;
  const VerifyEmailPage({
    super.key,
    required this.otp,
    required this.email,
  });

  @override
  State<VerifyEmailPage> createState() =>
      _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController codeController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Column(
              children: [
                Text(
                  'Verify Email',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Enter the 6-digit code sent to your email',
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
                            PhosphorIconsRegular.password,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: codeController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText:
                                  "Enter your 6-digit code",
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap:
                              () => {
                                if (widget.otp ==
                                    codeController.text)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (
                                              context,
                                            ) => ResetPasswordPage(
                                              email:
                                                  widget
                                                      .email,
                                            ),
                                      ),
                                    ),
                                  }
                                else
                                  {
                                    print(
                                      codeController.text,
                                    ),
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Wrong OTP",
                                        ),
                                      ),
                                    ),
                                  },
                              },
                          child: Text(
                            'Verify Code',
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
                    Text("Don't get the code?"),
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
                        'Resend',
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
