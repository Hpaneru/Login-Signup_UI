import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../signup.dart';
import '../homepage.dart';

class UserManagement {
  FirebaseUser firebaseUser;

  storeNewUser(User result, context) async {
    var ref = Firestore.instance.collection('users');
    await ref.document(result.id).setData({
      'email': result.email,
      'uid': result.id,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    }).catchError((e) {
      print(e);
    });
  }
}
