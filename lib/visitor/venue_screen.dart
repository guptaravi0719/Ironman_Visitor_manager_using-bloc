import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visitor_management/auth/auth.dart';
import 'package:visitor_management/auth/visitor_auth.dart';
import 'package:visitor_management/visitor/page_route.dart';
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
          title: Text(
            "Venue Login",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.8,
                  child: Image.asset("assets/logo_horizontal.png"),
                ),
                ButtonTheme(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.orange[300],
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlideRightRoute(widget: VisitorCategorySelectScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.done_outline,
                          color: Colors.white,
                          size: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ButtonTheme(
                  minWidth: 100,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      try {
                        await auth.signOut();

                        Navigator.push(
                            context,
                            SlideRightRoute(
                              widget:
                                  LoginPage(auth: auth, onSignedIn: onsignedIn),
                            ));
                      } catch (e) {
                        print(
                            "Error signing out ${e} xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign Out",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 20.0,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
