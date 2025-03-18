import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, String>> trafficInfo = [
    {
      'title': 'Traffic',
      'type': 'Current congestion: ',
      'description': '75%',
      'time': '5',
    },
    {
      'title': 'Pollution',
      'type': 'AQI Level: ',
      'description': '112',
      'time': '10',
    },
    {
      'title': 'Energy',
      'type': 'Consumption: ',
      'description': '1.2 GW',
      'time': '15',
    },
    {
      'title': 'Traffic',
      'type': 'Current congestion: ',
      'description': '60%',
      'time': '25',
    },
    {
      'title': 'Polution',
      'type': 'AQI Level: ',
      'description': '98',
      'time': '20',
    },
    {
      'title': 'Energy',
      'type': 'Consumption: ',
      'description': '1.5 GW',
      'time': '30',
    },
  ];

  int onTap = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      PhosphorIcon(
                        PhosphorIconsRegular.info,
                      ),
                      PhosphorIcon(
                        PhosphorIconsRegular.chatText,
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
                            color: Colors.amber,
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
                          'Map',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.amber,
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
                          'AI',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0),
              ),
            ),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:
                    trafficInfo
                        .length, // Number of items in the list
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        border: Border.all(width: 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    trafficInfo[index]['title'] ??
                                        'No title',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${trafficInfo[index]['type'] ?? 'No title'} ${trafficInfo[index]['description'] ?? 'No description'}',
                                  ),
                                  Text(
                                    trafficInfo[index]['time'] ??
                                        'No title',
                                  ),
                                ],
                              ),
                              Container(
                                width: 100,
                                child: Center(
                                  child: Text('Image'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
