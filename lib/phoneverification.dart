import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loginui/homepage.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                       this.smsOTP = value;
                      },
                    ),
                  ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =(await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: TextField(
                    decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Ph.No. Eg. +910000000000',
                    prefixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    this.phoneNo = value;
                  },
                ),
              ),
            ),
            (errorMessage != ''
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  'VERIFY',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff272a39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  verifyPhone();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
