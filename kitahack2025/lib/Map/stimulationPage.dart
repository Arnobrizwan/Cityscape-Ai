import 'package:flutter/material.dart';
import 'package:kitahack2025/Map/trafficOptimizationPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StimluationPage extends StatefulWidget {
  const StimluationPage({super.key});

  @override
  State<StimluationPage> createState() =>
      _StimluationPageState();
}

class _StimluationPageState extends State<StimluationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    TrafficOptimizationPage(),
                          ),
                        );
                      },
                      child: PhosphorIcon(
                        PhosphorIconsRegular.arrowLeft,
                      ),
                    ),
                    Text(
                      'Digital Twin monitoring',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0),
                    ),
                  ),
                ),

                SizedBox(
                  height: 200,
                  child: Center(child: Text('Image')),
                ),
                Text(
                  'ajsfuidabfiuewabfiusdabfiudfbauisdbfuisdabfuidsabfiudabfiusdabfdusabfdusiabfdui',
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'AI Recomendations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Consider taking an alternative route.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
