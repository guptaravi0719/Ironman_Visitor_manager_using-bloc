import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/auth/otp_screen.dart';
import 'package:visitor_management/auth/uploading_image_dialogue.dart';
import 'package:visitor_management/data_to_be_added';

import 'package:visitor_management/visitor/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visitor_management/visitor/visitor_detail_form_screen.dart';

class PhoneAuthScreen extends StatefulWidget {

  String category;
  PhoneAuthScreen({this.category});


  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {




@override
  void initState() {
 FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
    // TODO: implement initState
    super.initState();
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String phoneNo;

  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {
    PhoneCodeSent smsCodeSent;
    smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId; Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                 OtpScreen(verificationId: verificationId,phoneNo:phoneNo,category: widget.category,)
          ));



     // smsCodeDialogue(context);
      print(forceCodeResend);
      print(smsCodeSent);
    };

    final PhoneVerificationCompleted verificationSuccess = (FirebaseUser user) async {
      Future<String> s;


Navigator.pop(context);
     uploadImage().whenComplete(() {


data_to_add['phone no']=phoneNo;                //adding phone no. to the Map after verification
data_to_add['url']= "http";
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VisitorDetailForm(category: widget.category,)
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




void  codeVerify(String otp) async {

  //FirebaseAuth.instance.signOut();
    FirebaseUser user;                  //verifying code on pressing done button on alert dialogue

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: otp);


   user=  await FirebaseAuth.instance
          .signInWithCredential(authCredential);

       // final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
       if(user!= null){
         print('signed in with phone number successful: user -> $user');




    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Phone:"),
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
                color: Colors.orange,
                child: Text("Send",),
                onPressed: () {
                  verifyPhone();
                 // FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
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
                     FirebaseStorage.instance.ref().child("photos/img_+${widget.category}+${Random().nextInt(999999)}");
      uploadTask = firebaseStorageRef.putFile(sampleImage);
if(uploadTask.isInProgress){
  uploadingImageDialogue(context);

  if(uploadTask.isSuccessful){Navigator.pop(context);}

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