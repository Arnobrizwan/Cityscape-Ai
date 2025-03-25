import 'package:flutter/material.dart';
import 'package:kitahack2025/Map/buildingComponent.dart';
import 'package:kitahack2025/Map/roadComponent.dart';
import 'package:kitahack2025/Map/trafficComponent.dart';
import 'package:kitahack2025/Map/trafficOptimizationPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int onTap = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              PhosphorIcon(PhosphorIconsRegular.arrowLeft),
              Text(
                '3D Simulation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PhosphorIcon(PhosphorIconsRegular.chartBar),
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
              // Building navigation
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
                      'Building',
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
              // Road Navigation
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
                      'Road',
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
              // Traffic Navigation
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
                      'Traffic',
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
            ? BuildingComponent()
            : onTap == 1
            ? RoadComponent()
            : TrafficComponent(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: GestureDetector(
            onTap:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TrafficOptimizationPage(),
                    ),
                  ),
                },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    'Stimulation',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
