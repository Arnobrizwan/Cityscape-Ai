import 'package:flutter/material.dart';

class BuildingComponent extends StatefulWidget {
  const BuildingComponent({super.key});

  @override
  State<BuildingComponent> createState() =>
      _BuildingComponentState();
}

class _BuildingComponentState
    extends State<BuildingComponent> {
  bool _buildingsSwitched = false;
  bool _roadsSwitched = false;
  bool _trafficSwitched = false;
  bool _environmentSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Center(child: Text('Image')),
        ),
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              // Buildings selection
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buildings',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Switch(
                    value: _buildingsSwitched,
                    onChanged: (value) {
                      setState(() {
                        _buildingsSwitched = value;
                      });
                    },
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
              // Roads selection
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Roads',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Switch(
                    value: _buildingsSwitched,
                    onChanged: (value) {
                      setState(() {
                        _roadsSwitched = value;
                      });
                    },
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Traffic',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Switch(
                    value: _buildingsSwitched,
                    onChanged: (value) {
                      setState(() {
                        _trafficSwitched = value;
                      });
                    },
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Environment',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Switch(
                    value: _environmentSwitched,
                    onChanged: (value) {
                      setState(() {
                        _buildingsSwitched = value;
                      });
                    },
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
