import 'dart:async';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visitor_management/auth/uploading_image_dialogue.dart';
import 'package:visitor_management/data_to_be_added';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:countdown/countdown.dart';
import 'package:visitor_management/visitor/image_picker.dart';
import 'package:visitor_management/visitor/visitor_detail_form_screen.dart';
// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {

  String verificationId;
  String category;
  var phoneNo;
  OtpScreen({this.verificationId
    ,this.phoneNo
    ,this.category
  });
 @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer _timer;
  int _start = 10;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
startTimer();                               //starts the countdown when state initializes
    super.initState();
  }
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            uploadImage().whenComplete((){                 //opening detail filling scree on verification of otp

              data_to_add['phone no']=widget.phoneNo;                //adding phone no. to the Map after verification
              data_to_add['url']= "http";

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VisitorDetailForm(category: widget.category,)
                  ));


            });

          }

          else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  static CountDown cd = CountDown(Duration(seconds : 10));
  // ignore: cancel_subscriptions
 static var  sub= cd.stream.listen(null);
  String smsCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/2.8,),
              Text("Enter Code"),
            TextField(
decoration: InputDecoration(hintText: "OTP"),
              onChanged: (value){
                smsCode=value;
              },

            ),

              SizedBox(height: 30.0,),
Text("$_start"),
              SizedBox(height: 30.0,),
              Padding(padding: EdgeInsets.all(20.0),child: RaisedButton(
                onPressed: (){
                  codeVerify(smsCode);

                },
                child: Text("Verify"),
              ),)

            ],


          ),
        ),
      ),
    );
  }
  void  codeVerify(String otp) async {


//    FirebaseUser user;

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId:widget.verificationId, smsCode: otp);



  FirebaseUser  user=  await FirebaseAuth.instance
        .signInWithCredential(authCredential);


    if(user!= null){

      print('signed in with phone number successful: user -> $user');




    // ignore: unnecessary_statements
    }else(debugPrint("CANNOT VERIFY OTP TRY AGAIN"));

  }
  Future<String> uploadImage() async {

    await  getImage();

    setState(() {
      sampleImage = tempImage;
    });


    StorageUploadTask uploadTask;
    try {

      final StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("photos/img_${widget.category}_${Random().nextInt(999999)}");
      uploadTask = firebaseStorageRef.putFile(sampleImage);
      if(uploadTask.isInProgress){
        uploadingImageDialogue(context);

        if(uploadTask.isSuccessful){Navigator.pop(context);}

       

      }


    } catch (e) {

      print(
          "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXError Uploading Image ${e.toString()}");
    }

    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downurl;
  }


}
