import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './home/homepage.dart';

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
  var latiitude = "";
  var longitude = "";
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latiitude = "${position.latitude}";
      longitude = "${position.longitude}";
      print('$longitude and $latiitude');
    });
  }

  String stringResponse;
  List listResponse;
  int woeid;
  Map mapResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.https("metaweather.com",
        "/api/location/search/", {"lattlong": "$latiitude,$longitude"}));
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
    return HomePage(
        minTemp, maxTemp, getCurrentLocation, fetchData, fetchWeather);
  }
}
