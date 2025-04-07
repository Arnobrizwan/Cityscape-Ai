import 'package:flutter/material.dart';
import 'package:kitahack2025/Map/buildingComponent.dart';
import 'package:kitahack2025/Extra/roadComponent.dart';
import 'package:kitahack2025/Extra/trafficComponent.dart';
import 'package:kitahack2025/Map/trafficOptimizationPage.dart';
import 'package:kitahack2025/bottomNavigation.dart';
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              BottomNaivgation(onSelect: 0),
                    ),
                  );
                },
                child: PhosphorIcon(
                  PhosphorIconsRegular.arrowLeft,
                ),
              ),
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

        SizedBox(height: 45),
        // Seperation Line
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0),
          ),
        ),

        BuildingComponent(),

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
