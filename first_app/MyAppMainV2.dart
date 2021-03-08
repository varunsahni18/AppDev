import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var count = 0;
  String billAmount = "", tipPer = "";
  void countPlus() {
    setState(() {
      count = count + 1;
    });
  }

  @override
  Widget build(
      BuildContext
          context) //build context is a data type and context is a variable
  {
    var question = ['Enter the Billing amount', 'Enter the tip percentage'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Tip Calculator')),
        body: Column(
          children: [
            Align(
                alignment: Alignment(0.00, -1.00),
                child: Text(
                  question.elementAt(0),
                  style: TextStyle(
                    fontFamily: 'RoblotaMono',
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                )),
            new TextField(
              decoration: new InputDecoration(hintText: "Type in here"),
              onSubmitted: (String str) {
                setState(() {
                  billAmount = str;
                  countPlus();
                });
              },
            ),
            Align(
                alignment: Alignment(0.00, -1.00),
                child: Text(
                  question.elementAt(1),
                  style: TextStyle(
                    fontFamily: 'RoblotaMono',
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                )),
            new TextField(
              decoration: new InputDecoration(hintText: "Type in here"),
              onSubmitted: (String str) {
                setState(() {
                  tipPer = str;
                  countPlus();
                });
              },
            ),
            Align(
                alignment: Alignment(0.00, 0.75),
                child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () => print('You clicked Submit'))),
          ],
        ),
        backgroundColor: Colors.tealAccent[100],
      ),
    );
  }
}
