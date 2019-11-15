import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {

  final LatLng coordinates;

  MapView(this.coordinates);
  @override
  _MapViewState createState() => _MapViewState(coordinates);
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  LatLng coordinates;

  // final LatLng _center = const LatLng(45.521563, -122.677433);
  _MapViewState(this.coordinates);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: coordinates,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}