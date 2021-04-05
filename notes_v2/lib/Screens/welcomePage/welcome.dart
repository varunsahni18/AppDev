import 'package:flutter/material.dart';
import 'package:notes/Screens/loginPage/home.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image:
                    NetworkImage('https://img.icons8.com/clouds/2x/note.png')),
            Text(
              'My Notes',
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.black12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
