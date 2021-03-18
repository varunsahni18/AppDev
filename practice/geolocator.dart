import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

//Future<Position> _determinePosition() async {
//  bool serviceEnabled;
//  LocationPermission permission;
//
//  serviceEnabled = await Geolocator.isLocationServiceEnabled();
//  if (!serviceEnabled) {
//    return Future.error('Location services are disabled.');
//  }
//
//  permission = await Geolocator.checkPermission();
//  if (permission == LocationPermission.deniedForever) {
//    return Future.error(
//        'Location permissions are permantly denied, we cannot request permissions.');
//  }
//
//  if (permission == LocationPermission.denied) {
//    permission = await Geolocator.requestPermission();
//    if (permission != LocationPermission.whileInUse &&
//        permission != LocationPermission.always) {
//      return Future.error(
//          'Location permissions are denied (actual value: $permission).');
//    }
//  }
//
//  return await Geolocator.getCurrentPosition();
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationApp(),
    );
  }
}

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  var locationMessage = "";
  // add this to the text widget
  //function to fetch the location
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('location app'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 46.0,
              color: Colors.blue,
            ),
            Text(
              "Get Users location",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(locationMessage),
            TextButton(
              onPressed: getCurrentLocation,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text(
                  'Get Current Location',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
