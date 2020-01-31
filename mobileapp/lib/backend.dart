import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'token.dart';

const url = "https://protean-triode-257507.appspot.com/lab";
const directions_api_url = "https://maps.googleapis.com/maps/api/directions/json?origin=33.695298, -117.888661&destination=33.716246, -117.945836&key=$token";
const snap_url = "https://roads.googleapis.com/v1/snapToRoads?path=33.69529800000001,-117.8886683|33.6942859,-117.8886669|33.6963258,-117.8982365|33.6999105,-117.8982586|33.7020979,-117.9194565|33.7137986,-117.9196229&interpolate=true&key=$token";

Future<String> req() async {
  final response = await http.get(url);
  return response.statusCode == 200
      ? response.body
      : throw Exception('Error: ${response.statusCode}');
}

// returns a list of polylines
Future<Set<Polyline>> getRoute() async {
  final response = await http.get(directions_api_url);
  if (response.statusCode == 200) {
     List steps = jsonDecode(response.body)['routes'][0]['legs'][0]['steps'];
     Set<Polyline> polyLines = Set<Polyline>();
     List<LatLng> latLngPairs = [];
     var i = 0;
     for (var step in steps) {
       latLngPairs.add(LatLng(step['start_location']['lat'], step['start_location']['lng']));
       print(step['start_location']['lat']);
       print(step['start_location']['lng']);
      polyLines.add(Polyline(
        polylineId: PolylineId(i.toString()),
        visible: true,
        color: Colors.red,
        points: [
          LatLng(step['start_location']['lat'], step['start_location']['lng']),
          LatLng(step['end_location']['lat'], step['end_location']['lng']),
        ]
      ));
     }
     var str = "";
     for (LatLng latlng in latLngPairs) {
       str += "${latlng.latitude},${latlng.longitude}|";
     }
     print(str);
     print(latLngPairs);
     return polyLines;

  }
  else {
    throw Exception('Error: ${response.statusCode}');
  }
}

Future<Set<Polyline>> getSnappedRoute() async {
  final response = await http.get(snap_url);
  if (response.statusCode == 200) {
     List steps = jsonDecode(response.body)['snappedPoints'];
     Set<Polyline> polyLines = Set<Polyline>();
     var i = 0;
     var first = true;
     LatLng prev;
     for (var step in steps) {
       print(step['location']['latitude']);
       print(step['location']['longitude']);
       if (first) {
         first = false;
         prev = LatLng(step['location']['latitude'], step['location']['longitude']);
       }
       else {
        polyLines.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          color: Colors.red,
          points: [
            prev,
            LatLng(step['location']['latitude'], step['location']['longitude']),
          ]
        ));
        prev = LatLng(step['location']['latitude'], step['location']['longitude']);
       }

     }
     return polyLines;

  }
  else {
    throw Exception('Error: ${response.statusCode}');
  }
}

