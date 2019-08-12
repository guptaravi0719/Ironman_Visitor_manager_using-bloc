import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialogue(context).then((value) {});
    };
    final PhoneVerificationCompleted verificationSuccess = (FirebaseUser user) {
      print('verified');
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + this.phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  Future<bool> smsCodeDialogue(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("SMS CODE :"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    codeVerify(smsCode);
                  },
                  child: Text("Done"))
            ],
          );
        });
  }

  codeVerify(smsCode) async {
    FirebaseAuth _firebaseAuth;
    try {
      AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: null, smsCode: smsCode);

      await _firebaseAuth
          .signInWithCredential(authCredential)
          .then((FirebaseUser user) async {
        final FirebaseUser currentUser = await _firebaseAuth.currentUser();
        assert(user.uid == currentUser.uid);
        print('signed in with phone number successful: user -> $user');


      }
      );  }
      catch(e){
      print ("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY${e.message}");

      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Phone no."),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter Mobile No."),
              onChanged: (value) {
                phoneNo = value;
              },
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();


              },
            )
          ],
        ),
      ),
    );
  }
}
