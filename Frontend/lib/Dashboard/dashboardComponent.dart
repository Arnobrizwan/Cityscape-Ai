import 'package:flutter/material.dart';

class Dashboardcomponent extends StatefulWidget {
  const Dashboardcomponent({super.key});

  @override
  State<Dashboardcomponent> createState() =>
      _DashboardcomponentState();
}

class _DashboardcomponentState
    extends State<Dashboardcomponent> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            trafficInfo[index]['title'] ??
                                'No title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                        child: Center(child: Text('Image')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
