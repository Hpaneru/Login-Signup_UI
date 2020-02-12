import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginui/Signup.dart';
import 'package:mdi/mdi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  SizedBox(height: 150.0),
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
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Forget Password ??'),
                        onPressed: () {},
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
                      onPressed: () {},
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
                          icon: Icon(Mdi.facebookBox),
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
