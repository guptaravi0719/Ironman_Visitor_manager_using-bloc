import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/auth/auth.dart';
import 'package:visitor_management/auth/visitor_auth.dart';
import 'package:visitor_management/visitor/visitor_category_select_screen.dart';

class VenueScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onsignedOut;
  final VoidCallback onsignedIn;

  VenueScreen({this.auth, this.onsignedOut, this.onsignedIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: GlobalKey(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                    try {
                      await auth.signOut();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(auth: auth, onSignedIn: onsignedIn),
                          ));
                    } catch (e) {
                      print(
                          "Error signing out ${e} xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
                    }
                  },
                  child: Text("Sign Out"),
                )
              ],
            ),
          ),
        ));
  }
}
