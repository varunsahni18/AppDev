import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue)),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black),
          icon: Icon(
            Icons.account_circle,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
