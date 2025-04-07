import 'package:flutter/material.dart';
import 'package:kitahack2025/Dashboard/aiComponent.dart';
import 'package:kitahack2025/Dashboard/dashboardComponent.dart';
import 'package:kitahack2025/Dashboard/mapComponent.dart';
import 'package:kitahack2025/Dashboard/chatBotPage.dart';
import 'package:kitahack2025/Dashboard/citizenFeedbackPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int onTap = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap:
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      CitizenFeedbackPage(),
                            ),
                          ),
                        },
                    child: PhosphorIcon(
                      PhosphorIconsRegular.info,
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ChatBotPage(),
                            ),
                          ),
                        },
                    child: PhosphorIcon(
                      PhosphorIconsRegular.chatText,
                    ),
                  ),
                  PhosphorIcon(
                    PhosphorIconsRegular.chartBar,
                  ),
                  Image.asset(
                    'lib/assets/Avatar.png',
                    width: 50, // Adjust the width
                    height: 50, // Adjust the height
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              // Dashboard navigation
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
                      'Dashboard',
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
              // Map Navigation
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
                      'Map',
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
              // AI Navigation
              GestureDetector(
                onTap:
                    () => {
                      setState(() {
                        onTap = 2;
                      }),
                    },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          onTap == 2
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
                      'AI',
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            onTap == 2
                                ? Colors.amber
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        // Seperation Line
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0),
          ),
        ),
        onTap == 0
            ? Dashboardcomponent()
            : onTap == 1
            ? MapComponent()
            : AIComponent(),
      ],
    );
  }
}
