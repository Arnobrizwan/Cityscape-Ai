import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TrafficOptimizationPage extends StatefulWidget {
  const TrafficOptimizationPage({super.key});

  @override
  State<TrafficOptimizationPage> createState() =>
      _TrafficOptimizationPageState();
}

class _TrafficOptimizationPageState
    extends State<TrafficOptimizationPage> {
  int onTap = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                    GestureDetector(
                      onTap: () => {Navigator.pop(context)},
                      child: PhosphorIcon(
                        PhosphorIconsRegular.arrowLeft,
                      ),
                    ),
                    Text(
                      'Traffic Optimization',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    PhosphorIcon(
                      PhosphorIconsRegular.mapPinArea,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular
                              .magnifyingGlass,
                        ),
                        SizedBox(width: 5),
                        Text('Filter by road or location'),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    // Dashboard
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
                          padding:
                              const EdgeInsets.symmetric(
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
                    // Live Map
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
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 35,
                              ),
                          child: Text(
                            'Live Map',
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
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0),
                  ),
                ),
                SizedBox(height: 20),
                onTap == 0
                    ? Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Control Panel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            // First Row
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Red Light',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 40s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Green Light',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 30s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Second Row
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Yellow Light',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 5s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Pedestrain Cross',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 20s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Third Row
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Left Turn',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 15s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Right Turn',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    Text('Duration: 10s'),
                                    Text(
                                      'Slider to adjust',
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal:
                                                    5,
                                              ),
                                          child: Text(
                                            'Apply/Simulate',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
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
                                'Apply',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: Text('Image'),
                          ),
                        ),
                        Container(
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
                                'Run Full Simulation',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.amber,
                            ),
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
                                'Back to Dashboard',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Text('Live Map'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
