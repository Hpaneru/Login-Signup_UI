import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:loginui/helpers/phone_verification.dart';
import 'package:loginui/helpers/facebook_login.dart';
import 'package:loginui/helpers/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginui/reset_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginui/homepage.dart';
import 'package:loginui/signup.dart';
import 'package:mdi/mdi.dart';

final FacebookLogin fbLogin = FacebookLogin();
final FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseUser currentUser;
  bool loading = false;
  String email, password;

  void showSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 140.0),
              Text('Login', style: Theme.of(context).textTheme.display1),
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
                    child: Text('Forgot Password?'),
                    onPressed: () async {
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                child: ResetPassword(),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))));
                          });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: RaisedButton(
                  child: loading == true
                      ? CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                      : Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    loginButtonAction(context);
                    setState(() {
                      loading = true;
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
                        facebookLogin().then((a) {
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
                            color: Colors.black, fontWeight: FontWeight.bold),
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
    );
  }

  void loginButtonAction(BuildContext context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((AuthResult user) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    }).catchError((e) {
      print(e.message);
      showSnackBar(e.message);
      setState(() {
        loading = false;
      });
    });
  }
}
