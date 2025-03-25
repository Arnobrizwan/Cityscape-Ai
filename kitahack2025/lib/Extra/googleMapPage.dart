import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() =>
      _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = LatLng(
    3.1390,
    101.6869,
  ); // Example: Kuala Lumpur

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map in Flutter")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId("location"),
            position: _initialPosition,
            infoWindow: InfoWindow(title: "Kuala Lumpur"),
          ),
        },
      ),
    );
  }
}
