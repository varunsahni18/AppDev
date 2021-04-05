import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotePage extends StatefulWidget {
  final String fullName;

  NotePage(this.fullName);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('${widget.fullName}');

    Future addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({'full_name': 'demo'})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    deleteDoc(DocumentSnapshot docToDelete) {
      return docToDelete.reference
          .delete()
          .then((value) => print("User Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    }

    return Scaffold(
      appBar: AppBar(title: Text('notes')),
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Center(
            child: TextButton(
              onPressed: () async {
                await addUser();
                print(snapshot.data.docs.length);
                deleteDoc(snapshot.data.docs[snapshot.data.docs.length - 1]);
              },
              child: Text(
                "Add User",
              ),
            ),
          );
        },
      ),
    );
  }
}
