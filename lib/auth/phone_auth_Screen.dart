import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/auth/otp_screen.dart';
import 'package:visitor_management/auth/uploading_image_dialogue.dart';
import 'package:visitor_management/connectivity_checker.dart';
import 'package:visitor_management/data_to_be_added';

import 'package:visitor_management/visitor/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visitor_management/visitor/page_route.dart';
import 'package:visitor_management/visitor/visitor_category_select_screen.dart';
import 'package:visitor_management/visitor/visitor_detail_form_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  String category;

  PhoneAuthScreen({this.category});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool isConnected;
  @override
  void initState() {

    connectivity =new Connectivity();
    subscription =connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      //do here something
      if(result==ConnectivityResult.mobile||result==ConnectivityResult.wifi){
        setState(() {
          isConnected=true;
        });
      }


    }

    );

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
subscription.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String phoneNo;

  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {
    PhoneCodeSent smsCodeSent;
    smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    verificationId: verificationId,
                    phoneNo: phoneNo,
                    category: widget.category,
                  )));

      // smsCodeDialogue(context);
      print(forceCodeResend);
      print(smsCodeSent);
    };

    final PhoneVerificationCompleted verificationSuccess =
        (FirebaseUser user) async {
      Future<String> s;

      Navigator.pop(context);
      s = uploadImage().whenComplete(() {
        data_to_add['phone no'] =
            phoneNo; //adding phone no. to the Map after verification
        data_to_add['url'] = '$s';

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VisitorDetailForm(
                      category: widget.category,
                    )));
      });

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

  void codeVerify(String otp) async {
    //FirebaseAuth.instance.signOut();
    FirebaseUser
        user; //verifying code on pressing done button on alert dialogue

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: otp);

    user = await FirebaseAuth.instance.signInWithCredential(authCredential);

    // final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      print('signed in with phone number successful: user -> $user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              SlideRightRoute(widget: VisitorCategorySelectScreen()),
            );
          },
        ),
        title: Text(
          "OTP Verification",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter Mobile Number",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter Mobile No.",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Phone No."),
                onChanged: (value) {
                  phoneNo = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              ButtonTheme(
                height: 50.0,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Send OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                                               verifyPhone();
                    // FirebaseAuth.instance.signOut();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    StorageReference ref;

    await getImage();

    setState(() {
      sampleImage = tempImage;
    });

    StorageUploadTask uploadTask;
    try {
      ref = FirebaseStorage.instance
          .ref()
          .child("photos/img_+${widget.category}+${Random().nextInt(999999)}");
      uploadTask = ref.putFile(sampleImage);
      if (uploadTask.isInProgress) {
        uploadingImageDialogue(context);

        if (uploadTask.isSuccessful) {
          Navigator.pop(context);
        }

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
    String url = dowurl.toString();

    data_to_add['url'] = url;
  }
}
