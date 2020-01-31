 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './backend.dart';

class AddPolylines extends StatefulWidget {
  @override
  _AddPolylinesState createState() => _AddPolylinesState();
}

class _AddPolylinesState extends State<AddPolylines> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(33.695298, -117.888661);

  final Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();

  LatLng _lastMapPosition = _center;

  List<LatLng> latlng = [
    LatLng(45.521563, -122.677433),
    LatLng(45.341563, -112.677433),
  ];

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() async {
    _polylines = await getRoute();
    setState(() {
      // _markers.add(Marker(
      //   // This marker id can be anything that uniquely identifies each marker.
      //   markerId: MarkerId(_lastMapPosition.toString()),
      //   position: _lastMapPosition,
      //   infoWindow: InfoWindow(
      //     title: 'Custom Marker',
      //     snippet: 'Inducesmile.com',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker,
      // ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Route'),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              polylines: _polylines,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    // FloatingActionButton(
                    //   onPressed: _onMapTypeButtonPressed,
                    //   materialTapTargetSize: MaterialTapTargetSize.padded,
                    //   backgroundColor: Colors.green,
                    //   child: const Icon(Icons.map, size: 36.0),
                    // ),
                    // SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}