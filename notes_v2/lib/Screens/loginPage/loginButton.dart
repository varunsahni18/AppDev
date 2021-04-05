import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/Screens/NotesPage/note.dart';
import 'package:notes/Screens/loginPage/home.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  String fullName;
  Future _addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection(fullName);
    return users
        .add({'full_name': 'demo'})
        .then((value) => print('User added'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteDoc(DocumentSnapshot docToDelete) {
    return docToDelete.reference
        .delete()
        .then((value) => print('User Deleted'));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(fullName);
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 3000,
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
            child: TextButton(
              onPressed: () async {
                User user;
                await firebaseAuth
                    .signInWithEmailAndPassword(
                        email: 'demo@gmail.com', password: 'demo123')
                    // ignore: non_constant_identifier_names
                    .then((UserCredential) {
                  setState(() {
                    user = UserCredential.user;
                  });
                  //Navigator.push(context,
                  //    MaterialPageRoute(builder: (context) => NotePage(user.email)));
                  print(user.email);
                  fullName = user.email;
                });
                await _addUser();
                print(snapshot.data.docs.length);
                deleteDoc(snapshot.data.docs[snapshot.data.docs.length - 1]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotePage(user.email)));
              },
              child: Text(
                'Login',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
        });
  }
}
