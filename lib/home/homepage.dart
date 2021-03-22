import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final minTemp;
  final maxTemp;
  final Function getCurrentLocation;
  final Function fetchData;
  final Function fetchWeather;
  HomePage(this.minTemp, this.maxTemp, this.getCurrentLocation, this.fetchData,
      this.fetchWeather);
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
