import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
String billAmount = "", tipPer = "";

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
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
                });
              },
            ),
            Align(
                alignment: Alignment(0.00, 0.75),
                child: RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage()),
                    );
                  },
                )),
          ],
        ),
        backgroundColor: Colors.tealAccent[100],
      ),
    );
  }
}

// new class, new page

class NextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NextPageState();
  }
}

class NextPageState extends State<NextPage> {
  @override
  Widget build(
      BuildContext
          context) //build context is a data type and context is a variable
  {
    var reply = ['Your Tip is equal to', 'Thank You'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Solution')),
        body: Column(
          children: [
            Align(
                alignment: Alignment(0.00, -1.00),
                child: Text(
                  " ${reply.elementAt(0)} ${tipPer.toString()}",
                  style: TextStyle(
                    fontFamily: 'RoblotaMono',
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                )),
            Align(
                alignment: Alignment(0.00, -1.00),
                child: Text(
                  reply.elementAt(1),
                  style: TextStyle(
                    fontFamily: 'RoblotaMono',
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                )),
            Align(
                alignment: Alignment(0.00, 0.75),
                child: RaisedButton(
                  child: Text('Return'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
        backgroundColor: Colors.tealAccent[100],
      ),
    );
  }
}
