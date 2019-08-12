import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/auth/auth.dart';
import 'package:visitor_management/auth/visitor_auth.dart';
import 'package:visitor_management/visitor/visitor_category_select_screen.dart';

class VenueScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onsignedOut;
  VenueScreen({this.auth, this.onsignedOut});
  void _signOut() async {
    try {
      await auth.signOut();


    } catch (e) {
      print("Error Signing out");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          title: Text("Venue Login"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Venue Login",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisitorCategorySelectScreen()),
                    );
                  },
                  child: Text("Proceed"),
                ),
                SizedBox(
                  height: 50.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    _signOut();
                  },
                  child: Text("Sign Out"),
                )
              ],
            ),
          ),
        ));
  }
}
