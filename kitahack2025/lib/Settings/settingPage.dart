import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              PhosphorIcon(PhosphorIconsRegular.arrowLeft),
              Text(
                'User Profile & Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PhosphorIcon(PhosphorIconsRegular.squareHalf),
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
                      Text('Role'),
                      PhosphorIcon(
                        PhosphorIconsRegular
                            .pencilSimpleLine,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIconsRegular.user,
                      ),
                      SizedBox(width: 5),
                      Text('Admin'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode'),
                      Switch(
                        value: _darkSwitch,
                        onChanged: (value) {
                          setState(() {
                            _darkSwitch = value;
                          });
                        },
                        activeColor: Colors.amber,
                        inactiveTrackColor: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Langauge'),
                      Text('English'),
                    ],
                  ),
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
                        padding: const EdgeInsets.symmetric(
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
                ],
              )
              : SizedBox(child: Text('settings')),
        ],
      ),
    );
  }
}
