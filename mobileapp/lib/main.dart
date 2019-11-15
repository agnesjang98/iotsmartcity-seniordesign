import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './mapview.dart';
import './backend.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  final latController = TextEditingController();
  final longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("IOT SmartCity"),
      ),
      body: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                labelText: "Destination Latitude",
                hintText: "e.g. 33.643653"
              ),
              controller: latController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                labelText: "Destination Longitude",
                hintText: "e.g. -117.841143"
              ),
              controller: longController,
            ),
            RaisedButton(
              child: Text("Get Route!"),
              onPressed: () async {
                print("response");
                var resp = await req();
                print(resp);
                var lat = double.parse(latController.text);
                var long = double.parse(longController.text);
                var coordinates = LatLng(lat, long);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapView(coordinates)
                    )
                );
  
              },
            )
          ],
        ),
    );
  }
}
