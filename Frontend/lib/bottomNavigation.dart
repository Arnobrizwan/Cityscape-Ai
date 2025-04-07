import 'package:flutter/material.dart';
import 'package:kitahack2025/Dashboard/chatBotPage.dart';
import 'package:kitahack2025/Dashboard/dashboardPage.dart';
import 'package:kitahack2025/AI/aiPage.dart';
import 'package:kitahack2025/Map/mapPage.dart';
import 'package:kitahack2025/Settings/settingPage.dart';
import 'package:kitahack2025/chatPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNaivgation extends StatefulWidget {
  final int onSelect;
  const BottomNaivgation({super.key, this.onSelect = 0});

  @override
  State<BottomNaivgation> createState() =>
      _BottomNaivgationState();
}

class _BottomNaivgationState
    extends State<BottomNaivgation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget
            .onSelect; // Set initial index based on widget's onSelect
  }

  List<Widget> pageSelection = [
    DashboardPage(),
    MapPage(),
    AIPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: pageSelection[_selectedIndex],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      // Dashboard
                      GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = 0;
                              }),
                            },
                        child: Column(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular
                                  .presentationChart,
                              color:
                                  _selectedIndex == 0
                                      ? Colors.amber
                                      : Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 15,
                                wordSpacing: 1,
                                color:
                                    _selectedIndex == 0
                                        ? Colors.amber
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ), // Map
                      GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = 1;
                              }),
                            },
                        child: Column(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular
                                  .mapTrifold,
                              size: 30,
                              color:
                                  _selectedIndex == 1
                                      ? Colors.amber
                                      : Colors.black,
                            ),
                            Text(
                              'Map',
                              style: TextStyle(
                                fontSize: 15,
                                wordSpacing: 1,
                                color:
                                    _selectedIndex == 1
                                        ? Colors.amber
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ), // AI
                      GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = 2;
                              }),
                            },
                        child: Column(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular
                                  .openAiLogo,
                              size: 30,
                              color:
                                  _selectedIndex == 2
                                      ? Colors.amber
                                      : Colors.black,
                            ),
                            Text(
                              'AI',
                              style: TextStyle(
                                fontSize: 15,
                                wordSpacing: 1,
                                color:
                                    _selectedIndex == 2
                                        ? Colors.amber
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ), // Settings
                      GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = 3;
                              }),
                            },
                        child: Column(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular.gear,
                              size: 30,
                              color:
                                  _selectedIndex == 3
                                      ? Colors.amber
                                      : Colors.black,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 15,
                                wordSpacing: 1,
                                color:
                                    _selectedIndex == 3
                                        ? Colors.amber
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20, // Position from the right side
              bottom:
                  80, // Position from the bottom (higher up)
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the desired page when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ), // Replace SomeNewPage() with your target page
                  );
                },
                backgroundColor: Colors.amber,
                child: PhosphorIcon(
                  PhosphorIconsRegular.chatCircleDots,
                ), // Set the color of the FAB
              ),
            ),
          ],
        ),
      ),
    );
  }
}
