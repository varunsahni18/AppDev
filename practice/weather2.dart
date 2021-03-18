import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

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
  var latitude = "";
  var longitude = "";
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = "${position.latitude}";
      longitude = "${position.longitude}";
    });
  }

  String stringResponse;
  List listResponse;
  int woeid;
  Map mapResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://metaweather.com/api/location/search?lattlong=$latitude,$longitude"));
    if (response.statusCode == 200) {
      setState(() {
        listResponse = jsonDecode(response.body);
        mapResponse = listResponse[0];
        woeid = mapResponse['woeid'];
        stringResponse = woeid.toString();
      });
    }
  }

  double minTemp;
  double maxTemp;
  Map weatherMapResponse;
  List weatherListResponse;
  Map consolidatedMap;

  Future fetchWeather() async {
    http.Response response;
    response = await http
        .get(Uri.https("metaweather.com", "/api/location/$stringResponse/"));
    if (response.statusCode == 200) {
      setState(() {
        weatherMapResponse = jsonDecode(response.body);
        weatherListResponse = weatherMapResponse["consolidated_weather"];
        consolidatedMap = weatherListResponse[0];
        minTemp = consolidatedMap['min_temp'];
        maxTemp = consolidatedMap['max_temp'];
      });
    }
  }

  void initState() {
    getCurrentLocation();
    fetchData();
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather app'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Weather",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text("min temp = ${minTemp.toString()}"),
            Text("max temp = ${maxTemp.toString()}"),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                getCurrentLocation();
                fetchData();
                fetchWeather();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text(
                  'Reload',
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
