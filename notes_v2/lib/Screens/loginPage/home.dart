import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/Screens/loginPage/email.dart';
import 'package:notes/Screens/loginPage/googleSign.dart';
import 'package:notes/Screens/loginPage/loginButton.dart';
import 'package:notes/Screens/loginPage/passward.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// creating global instances for firebase and googleSignin
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
  String fullName = '';
  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    //calling Signin method for the google sign in object which is included in the google sign in package.
    // it will display a pop up to select the account with which we would sign in.
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //it is used to varify that the authenticcation was performed correctly.
    // now to tell the firebase to allow this user to acess the application
    // and to add him to our database

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    // firebase at the backend will be comunication with the google server
    // and ask if the applicaton can acess the details of the user.
    // Now, to get the details of the user that is signed in
    //
    final User user =
        (await firebaseAuth.signInWithCredential(credential)).user;

    setState(() {
      fullName = user.email;
    });
    //   Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => NotePage(user.email)));
  }

  Future addUser() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('$fullName');
    // Call the user's CollectionReference to add a new user
    return users
        .add({'full_name': 'demo'})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteDoc(DocumentSnapshot docToDelete) {
    return docToDelete.reference
        .delete()
        .then((value) => print('User Deleted'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to My notes",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Enter your Email and Password to continue",
                  style: GoogleFonts.openSans(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25),
              Email(),
              SizedBox(height: 15),
              Password(),
              SizedBox(height: 20),
              LoginButton(),
              SizedBox(height: 35),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Login by your Google Account",
                  style: GoogleFonts.openSans(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              GoogleSign(_signInWithGoogle, addUser, deleteDoc, fullName),
            ],
          ),
        ),
      ),
    );
  }
}
