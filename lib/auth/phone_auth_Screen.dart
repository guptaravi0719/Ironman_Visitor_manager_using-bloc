import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/data_to_be_added';

import 'package:visitor_management/visitor/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visitor_management/visitor/visitor_detail_form_screen.dart';

class PhoneAuthScreen extends StatefulWidget {


  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {


  FirebaseAuth _firebaseAuth;
  FirebaseUser _user;
@override
  void initState() {
  _firebaseAuth=FirebaseAuth.instance;
    // TODO: implement initState
    super.initState();
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String phoneNo;

  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialogue(context).then((value) {});
    };
    final PhoneVerificationCompleted verificationSuccess = (FirebaseUser user) async {
      Future<String> s;
Navigator.pop(context);
     uploadImage().whenComplete(() {


data_to_add['phone no']=phoneNo;
data_to_add['url']= "http";
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VisitorDetailForm()
            ));
      }

      );


      print('verified');


    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
  );
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
                  onPressed: () async {

                    Navigator.pop(context);
                    codeVerify(smsCode);
            // FirebaseAuth.instance.signInWithPhoneNumber();







                  },
                  child: Text("Done"))
            ],
          );
        });
  }
  Future<bool> smsCodeDialogue1(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("SMS CODE :"),
            content: Row(children: <Widget>[
              Text("Uploading photo please wait..")

            ],),

          );
        });
  }

void  codeVerify(smsCode) async {

  FirebaseAuth.instance.signOut();
    FirebaseUser user;                  //verifying code on pressing done button on alert dialogue

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);



   user=  await FirebaseAuth.instance
          .signInWithCredential(authCredential);

       // final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
       if(user!= null){
         print('signed in with phone number successful: user -> $user');




    }
//       catch (e) {
//
//      _scaffoldKey.currentState.showSnackBar(
//        SnackBar(
//          content: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Text('Verificaton failed'),
//              Icon(Icons.error)
//            ],
//          ),
//          backgroundColor: Colors.red,
//        ),
//      );
//
//      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY${e.toString()}");
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Verify"),
      ),
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
               // FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<String> uploadImage() async {

  await  getImage();

    setState(() {
      sampleImage = tempImage;
    });


    StorageUploadTask uploadTask;
    try {

      final StorageReference firebaseStorageRef =
                     FirebaseStorage.instance.ref().child("photos/ravi.img");
      uploadTask = firebaseStorageRef.putFile(sampleImage);
if(uploadTask.isInProgress){
  smsCodeDialogue1(context);

  if(uploadTask.isSuccessful){Navigator.pop(context);}

//  _scaffoldKey.currentState
//    ..hideCurrentSnackBar()
//    ..showSnackBar(
//      SnackBar(
//        content: Row(
//          mainAxisAlignment:
//          MainAxisAlignment.spaceBetween,
//          children: [
//            Text('Uploading Please wait...'),
//            CircularProgressIndicator()
//          ],
//        ),
//        backgroundColor: Colors.black,
//      ),
//    );


  print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYUploadingYYYYYYYYYYYYYYYYYY");

}


    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Error Uploading image. Please Try again...'),
              Icon(Icons.error)
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
      print(
          "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXError Uploading Image ${e.toString()}");
    }

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return dowurl.toString();
  }
}
