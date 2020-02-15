import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:loginui/homepage.dart';
import 'package:mdi/mdi.dart';

import 'login.dart';
import 'services/usermanagement.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  User userInfo = User();
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 115.0),
                  Text(
                    'Sign Up',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 110.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        setState(() {
                          userInfo.email = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff272a39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: userInfo.email, password: password)
                            .then((signedInUser) {
                          userInfo.id = signedInUser.user.uid;
                          UserManagement().storeNewUser(userInfo, context);
                          //  Navigator.pushReplacement(context,
                          //   MaterialPageRoute(builder: (context) => Homepage()));
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('or'),
                  Padding(
                    padding: EdgeInsets.only(left: 115.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Mdi.phone),
                          onPressed: () {},
                          color: Colors.blue,
                          iconSize: 40.0,
                        ),
                        IconButton(
                          icon: Icon(Mdi.twitter),
                          onPressed: () {},
                          color: Colors.blue,
                          iconSize: 40.0,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  RichText(
                    text: TextSpan(
                        text: 'already account?',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' LOGIN',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  String id;
  String email;

  User({this.id, this.email});
}
