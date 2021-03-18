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

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.https("thegrowingdeveloper.org", "/apiview", {"id": "4"}));
    if (response.statusCode == 200) {
      setState(() {
        listResponse = jsonDecode(response.body);
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
      body: listResponse == null
          ? Container()
          : Text(
              listResponse[3].toString(),
              style: TextStyle(fontSize: 20),
            ),
    );
  }
}
