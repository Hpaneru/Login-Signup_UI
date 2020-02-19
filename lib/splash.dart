import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
     FirebaseAuth.instance.currentUser().then((user){
       if(user==null){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
       }
       else {
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Homepage()));
       }
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CircularProgressIndicator(),
      ),      
    );
  }
}