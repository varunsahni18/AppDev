import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/NotesPage/note.dart';

class GoogleSign extends StatelessWidget {
  final Function _signInWithGoogle;
  final Function _addUser;
  final Function _deleteDoc;
  final String email;

  GoogleSign(
      this._signInWithGoogle, this._addUser, this._deleteDoc, this.email);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(email);
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.black12),
              ],
            ),
            child: ListTile(
              title: Text(
                'Sign-in with Google',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              leading: Image(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/7e/a2/a0/7ea2a086cc5082330324a94c52a66531.png'),
                height: 40,
                width: 40,
              ),
              onTap: () async {
                await _signInWithGoogle();
                await _addUser();
                print(snapshot.data.docs.length);
                _deleteDoc(snapshot.data.docs[snapshot.data.docs.length - 1]);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotePage(email)));
              },
            ),
          );
        });
  }
}
