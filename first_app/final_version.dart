import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

int bill, tip;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void dispose2() {
    // Clean up the controller when the widget is disposed.
    _controller2.dispose();
    super.dispose();
  }

  Widget build(
      BuildContext
          context) //build context is a data type and context is a variable
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tip Calculator"),
        ),
        backgroundColor: Colors.brown[50],
        body: Column(
          children: [
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Enter Amount",
                  labelText: "Billing Amount",
                  border: InputBorder.none,
                  fillColor: Colors.blue[100],
                  filled: true,
                  //prefixIcon: Icon(Icon.name_of_Icon) - to add an icon
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Enter Tip",
                  labelText: "Tip Percentage",
                  border: InputBorder.none,
                  fillColor: Colors.blue[100],
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            RaisedButton(
                child: Text('NextPage'),
                onPressed: () {
                  bill = int.parse(_controller.text);
                  tip = int.parse(_controller2.text);
                  print(tip);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                }),
          ],
        ),
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
  double calculate() {
    return (bill + bill * (tip / 100));
  }

  @override
  Widget build(
      BuildContext
          context) //build context is a data type and context is a variable
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Total Amount')),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    " Your Total Amout is equal\n to ${calculate()}",
                    style: TextStyle(
                      fontFamily: 'RoblotaMono',
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
