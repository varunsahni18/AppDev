import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;
  Map mapResponse;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.https("thegrowingdeveloper.org", "/apiview", {"id": "2"}));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data'),
        backgroundColor: Colors.blue[900],
      ),
      body: mapResponse == null
          ? Container()
          : Column(
              children: [
                Text(
                  mapResponse['category'].toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(listResponse[0]['title']),
              ],
            ),
    );
  }
}
