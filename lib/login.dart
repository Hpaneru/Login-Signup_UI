import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginui/Signup.dart';
import 'package:loginui/googlesignin.dart';
import 'package:loginui/homepage.dart';
import 'package:loginui/phoneverification.dart';
import 'package:loginui/resetpassword.dart';
import 'package:mdi/mdi.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
  final FacebookLogin fbLogin = FacebookLogin();
  final FirebaseAuth auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  // bool isFacebookLoginIn = false;
  // String errorMessage = '';
  // String successMessage = '';
  //FirebaseUser fbUser;
    FirebaseUser currentUser;

  String email, password;
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
                  SizedBox(height: 140.0),
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50.0),
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
                          email = value;
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
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Forgot Password ??'),
                        onPressed: () async {
                          await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: ResetPassword(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))));
                              });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff272a39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((AuthResult user) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        }).catchError((e) {
                          print(e.message);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('or'),
                  Padding(
                    padding: EdgeInsets.only(left: 85.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Mdi.phone),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneAuthScreen()));
                          },
                          color: Colors.blue,
                          iconSize: 40.0,
                        ),
                        IconButton(
                          icon: Icon(Mdi.google),
                          onPressed: () {
                            signInWithGoogle().then((a) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            });
                          },
                          color: Colors.blue,
                          iconSize: 40.0,
                        ),
                        IconButton(
                          icon: Icon(Mdi.facebook),
                          onPressed: () {
                            facebookLogin(context).then((a) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            });
                          },
                          color: Colors.blue,
                          iconSize: 40.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                        text: 'don\'t have a account?',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' SIGN UP',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
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

Future<FirebaseUser> facebookLogin(BuildContext context) async {
  FirebaseUser currentUser;
  try {
    final FacebookLoginResult facebookLoginResult =
        await fbLogin.logIn(['email']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      final FirebaseUser user =
          (await auth.signInWithCredential(credential)).user;
      currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return currentUser;
    }
  } catch (e) {
    print(e);
  }
  return currentUser;
}

Future<bool> facebookLoginout() async {
  await auth.signOut();
  await fbLogin.logOut();
  return true;
}
