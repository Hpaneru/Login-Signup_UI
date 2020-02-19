import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'helpers/google_signin.dart';
import 'helpers/facebook_login.dart';
import 'login.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }).catchError((e) {
              print(e);
            });
            signOutGoogle();

            facebookLoginout();
          },
        ));
  }
}
