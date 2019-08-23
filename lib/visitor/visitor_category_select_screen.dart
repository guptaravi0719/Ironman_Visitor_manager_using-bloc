import 'package:flutter/material.dart';
import 'package:visitor_management/auth/mobile_verification_screen.dart';
import 'package:visitor_management/auth/phone_auth_Screen.dart';

class VisitorCategorySelectScreen extends StatefulWidget {
  @override
  _VisitorCategorySelectScreenState createState() =>
      _VisitorCategorySelectScreenState();
}

class _VisitorCategorySelectScreenState
    extends State<VisitorCategorySelectScreen> {
  final formKey = new GlobalKey<FormState>();

  String _namel;
  String _person_to_meet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Categories")

    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text("Visitor"),
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
              //        builder: (context) => PhoneAuthScreen(category:"Visitor")),
                      builder: (context) => MobileNumberVerifyScreen()),

                );


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Vendor"),
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(category:"Vendor")),
                );


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("91 Lead"),
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(category:"91 Lead")),
                );


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Courier"),
              onPressed: (){

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(category:"Courier")),
                );

              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Day Pass"),
              onPressed: (){

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(category:"Day Pass")),
                );

              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),





          ],


        ),
      ),


    );
  }
}
