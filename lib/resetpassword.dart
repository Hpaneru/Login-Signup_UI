import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Text(
              'RESET PASSWORD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'ENTER EMAIL',
                  prefixIcon: Icon(Icons.mail),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                FlatButton(
                  onPressed: () async {
                      Navigator.pop(context);
                    await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);
                  },
                  child: Text('Save'),
                )
              ],
            )
          ],
        ));
  }
}
