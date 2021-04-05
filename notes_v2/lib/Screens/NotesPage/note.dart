import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final String fullName;
  NotePage(this.fullName);
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notes')),
      body: Text("hello"),
    );
  }
}
