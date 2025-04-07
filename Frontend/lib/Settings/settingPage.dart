import 'package:flutter/material.dart';
import 'package:kitahack2025/LoginPage/authentication.dart';
import 'package:kitahack2025/Settings/feedbackPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int onTap = 0;
  bool _darkSwitch = false;
  bool _notificationSwitch = false;
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                PhosphorIcon(
                  PhosphorIconsRegular.arrowLeft,
                ),
                Text(
                  'User Profile & Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PhosphorIcon(
                  PhosphorIconsRegular.squareHalf,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                // ViewProfile navigation
                GestureDetector(
                  onTap:
                      () => {
                        setState(() {
                          onTap = 0;
                        }),
                      },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            onTap == 0
                                ? BorderSide(
                                  width: 3,
                                  color: Colors.amber,
                                )
                                : BorderSide.none,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 35,
                      ),
                      child: Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              onTap == 0
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // Setting Navigation
                GestureDetector(
                  onTap:
                      () => {
                        setState(() {
                          onTap = 1;
                        }),
                      },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            onTap == 1
                                ? BorderSide(
                                  width: 3,
                                  color: Colors.amber,
                                )
                                : BorderSide.none,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 35,
                      ),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              onTap == 1
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0),
                ),
              ),
            ),
            onTap == 0
                ? Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name'),
                        PhosphorIcon(
                          PhosphorIconsRegular
                              .pencilSimpleLine,
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(width: 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Text('Angela Lee'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Email Address'),
                        PhosphorIcon(
                          PhosphorIconsRegular
                              .pencilSimpleLine,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(width: 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Text('angelalee@gmail.com'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone Number'),
                        PhosphorIcon(
                          PhosphorIconsRegular
                              .pencilSimpleLine,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(width: 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Text('60123456789'),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Role'),
                    //     PhosphorIcon(
                    //       PhosphorIconsRegular
                    //           .pencilSimpleLine,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     PhosphorIcon(
                    //       PhosphorIconsRegular.user,
                    //     ),
                    //     SizedBox(width: 5),
                    //     Text('Admin'),
                    //   ],
                    // ),
                    // SizedBox(height: 30),
                    // Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Dark Mode'),
                    //     Switch(
                    //       value: _darkSwitch,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _darkSwitch = value;
                    //         });
                    //       },
                    //       activeColor: Colors.amber,
                    //       inactiveTrackColor: Colors.grey,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Langauge'),
                    //     Text('English'),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Notifications'),
                        Switch(
                          value: _notificationSwitch,
                          onChanged: (value) {
                            setState(() {
                              _notificationSwitch = value;
                            });
                          },
                          activeColor: Colors.amber,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                vertical: 10,
                              ),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        _authService.signOut(
                          context: context,
                        );
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
                                  vertical: 10,
                                ),
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : SizedBox(
                  child: Column(
                    children: [
                      // Personal Informaiton
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular.user,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Personal information'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Text Size
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular
                                      .textAa,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Text Size'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Medium'),
                              SizedBox(width: 5),
                              PhosphorIcon(
                                PhosphorIconsRegular
                                    .caretRight,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Security
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular.user,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Security'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Privacy
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular
                                      .lockKey,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Privacy'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Notification
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular.bell,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Notification'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Help Support
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular
                                      .questionMark,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Help & Support'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Feedback
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Feedbackpage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(
                                          5,
                                        ),
                                    border: Border.all(
                                      width: 0,
                                    ),
                                  ),
                                  child: PhosphorIcon(
                                    PhosphorIconsRegular
                                        .smiley,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text('Feedback'),
                              ],
                            ),
                            PhosphorIcon(
                              PhosphorIconsRegular
                                  .caretRight,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // Payment
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular
                                      .creditCard,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Payment'),
                            ],
                          ),
                          PhosphorIcon(
                            PhosphorIconsRegular.caretRight,
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
