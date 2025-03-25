import 'package:flutter/material.dart';
import 'package:kitahack2025/Dashboard/dashboardPage.dart';
import 'package:kitahack2025/AI/aiPage.dart';
import 'package:kitahack2025/Map/mapPage.dart';
import 'package:kitahack2025/Settings/settingPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNaivgation extends StatefulWidget {
  const BottomNaivgation({super.key});

  @override
  State<BottomNaivgation> createState() =>
      _BottomNaivgationState();
}

class _BottomNaivgationState
    extends State<BottomNaivgation> {
  List<Widget> pageSelection = [
    DashboardPage(),
    MapPage(),
    AIPage(),
    SettingPage(),
  ];
  int onSelected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: pageSelection[onSelected]),
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
                            onSelected = 0;
                          }),
                        },
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular
                              .presentationChart,
                          color:
                              onSelected == 0
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
                                onSelected == 0
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
                            onSelected = 1;
                          }),
                        },
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.mapTrifold,
                          size: 30,
                          color:
                              onSelected == 1
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                        Text(
                          'Map',
                          style: TextStyle(
                            fontSize: 15,
                            wordSpacing: 1,
                            color:
                                onSelected == 1
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
                            onSelected = 2;
                          }),
                        },
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.openAiLogo,
                          size: 30,
                          color:
                              onSelected == 2
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                        Text(
                          'AI',
                          style: TextStyle(
                            fontSize: 15,
                            wordSpacing: 1,
                            color:
                                onSelected == 2
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
                            onSelected = 3;
                          }),
                        },
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.gear,
                          size: 30,
                          color:
                              onSelected == 3
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 15,
                            wordSpacing: 1,
                            color:
                                onSelected == 3
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
      ),
    );
  }
}
