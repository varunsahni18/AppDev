import 'dart:html';

import 'package:flutter/material.dart';

Coordinates() {
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
}
