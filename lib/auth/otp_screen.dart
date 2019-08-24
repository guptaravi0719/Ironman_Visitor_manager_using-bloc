import 'dart:async';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visitor_management/auth/uploading_image_dialogue.dart';
import 'package:visitor_management/data_to_be_added';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:countdown/countdown.dart';
import 'package:visitor_management/visitor/image_picker.dart';
import 'package:visitor_management/visitor/page_route.dart';
import 'package:visitor_management/visitor/visitor_detail_form_screen.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String verificationId;
  String category;
  var phoneNo;

  OtpScreen({this.verificationId, this.phoneNo, this.category});

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
    startTimer(); //starts the countdown when state initializes
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
             var s;
            timer.cancel();
         s=  uploadImage().whenComplete(() {
              //opening detail filling scree on verification of otp

              data_to_add['phone no'] = widget
                  .phoneNo; //adding phone no. to the Map after verification


              Navigator.pushReplacement(
                  context,
                  SlideRightRoute(
                      widget: VisitorDetailForm(
                    category: widget.category,
                  )));
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  static CountDown cd = CountDown(Duration(seconds: 10));

  // ignore: cancel_subscriptions
  static var sub = cd.stream.listen(null);
  String smsCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Verification",style: TextStyle(color: Colors.white),),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(
              context,
              SlideRightRoute()

            );

          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: 300,
            width: 300,
            child: Card(
              elevation: 10.0,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "OTP",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        onChanged: (value) {
                          smsCode = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(child: Text("Time Remaining: 0:$_start")),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),

                        onPressed: () {
                          codeVerify(smsCode);
                        },
                        child: Text("Verify"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void codeVerify(String otp) async {
//    FirebaseUser user;

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: widget.verificationId, smsCode: otp);

    FirebaseUser user =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    if (user != null) {
      print('signed in with phone number successful: user -> $user');

      // ignore: unnecessary_statements
    } else
      (debugPrint("CANNOT VERIFY OTP TRY AGAIN"));
  }

  Future<String> uploadImage() async {
    await getImage();
    StorageReference ref;
    setState(() {
      sampleImage = tempImage;
    });

    StorageUploadTask uploadTask;
    try {
     ref  = FirebaseStorage.instance
          .ref()
          .child("photos/img_${widget.category}_${Random().nextInt(999999)}");
      uploadTask = ref.putFile(sampleImage);
      if (uploadTask.isInProgress) {
        uploadingImageDialogue(context);

        if (uploadTask.isSuccessful) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print(
          "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXError Uploading Image ${e.toString()}");
    }

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
  var  url = dowurl.toString();
data_to_add['url']=url;

  }
}
