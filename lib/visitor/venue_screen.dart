import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitor_management/auth/auth.dart';
import 'package:visitor_management/auth/visitor_auth.dart';
import 'package:visitor_management/settings/location.dart';
import 'package:visitor_management/settings/location_shared_prefrences.dart';

import 'package:visitor_management/visitor/page_route.dart';
import 'package:visitor_management/visitor/visitor_category_select_screen.dart';

class VenueScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onsignedOut;
  final VoidCallback onsignedIn;

  VenueScreen({this.auth, this.onsignedOut, this.onsignedIn});

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  @override
  void initState() {
  futureLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ButtonTheme(
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.orange[300],
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        if (location != null) {
                          Navigator.push(
                            context,
                            SlideRightRoute(
                                widget: VisitorCategorySelectScreen()),
                          );
                        } else {
                          _showErrorFloatingFlushbar(
                              context,
                              'No Location Selected',
                              'Please Select any Location');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Proceed",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
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
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ButtonTheme(
                    minWidth: 100,
                    height: 50.0,
                    child: OutlineButton(
                      highlightedBorderColor: Theme.of(context).primaryColor,
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      disabledBorderColor: Theme.of(context).primaryColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                        _showSignOutFloatingFlushbar(context);
                        try {
                          await FirebaseAuth.instance.signOut();
                          Future.delayed(Duration(seconds: 2))
                              .whenComplete(() async {
//   Navigator.pushReplacement(
//       context,
//       SlideRightRoute(
//         widget:
//         LoginPage(auth: auth, onSignedIn: onsignedIn),
//       ));

                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                      auth: widget.auth,
                                      onSignedIn: widget.onsignedIn)),
                            );
                          });
                        } catch (e) {
                          _showErrorFloatingFlushbar(
                              context, "Error Signing Out ", 'Try Again!');
                          print(
                              "Error signing out ${e} xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Sign Out",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Theme.of(context).primaryColor,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Current Location: ",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    location == null
                        ? Text(
                            "No Location Selected",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            location,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  void _showSignOutFloatingFlushbar(BuildContext context) {
    Flushbar(
      backgroundColor: Colors.orange,
      margin: EdgeInsets.all(0),
      showProgressIndicator: true,
      duration: Duration(seconds: 4),
      borderRadius: 5.0,
      //animationDuration: Duration(seconds: 2),
      isDismissible: true,
      padding: EdgeInsets.all(8.0),

      backgroundGradient: LinearGradient(
        colors: [Colors.orange[300], Colors.orange[200]],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Signing Out..',
      message: 'Bye Bye!',
    ).show(context);
  }

  void _showErrorFloatingFlushbar(
      BuildContext context, String title, String message) {
    Flushbar(
      backgroundColor: Colors.orange,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(5.0),
      borderRadius: 5.0,
      duration: Duration(seconds: 2),
      animationDuration: Duration(seconds: 2),

      borderColor: Colors.white,
      isDismissible: true,
//      padding: EdgeInsets.all(12.0),
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade400, Colors.redAccent.shade200],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title,
      message: 'please try again',
    ).show(context);
  }


  futureLocation() {
    getLocationValuesSF().then((value) {
      setState(() {
        location = value;
      });
    });
  futureVisitorBool() {
    getAdminBoolValuesSF().then((value) {
      setState(() {
        visitorBool = value;
      });
    }


    );
  }
  }
}
