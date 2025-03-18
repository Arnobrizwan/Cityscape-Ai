import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNaivgation extends StatefulWidget {
  const BottomNaivgation({super.key});

  @override
  State<BottomNaivgation> createState() =>
      _BottomNaivgationState();
}

class _BottomNaivgationState
    extends State<BottomNaivgation> {
  int onSelected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
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
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 10,
                          wordSpacing: 1,
                          color:
                              onSelected == 0
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ), // Dashboard
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
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 10,
                          wordSpacing: 1,
                          color:
                              onSelected == 0
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ), // Dashboard
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
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 10,
                          wordSpacing: 1,
                          color:
                              onSelected == 0
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ), // Dashboard
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
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 10,
                          wordSpacing: 1,
                          color:
                              onSelected == 0
                                  ? Colors.amber
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
