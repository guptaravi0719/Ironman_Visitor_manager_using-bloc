import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:visitor_management/admin/admin_portal.dart';
import 'package:visitor_management/admin/admin_screen_tabs.dart';
import 'package:visitor_management/settings/location_shared_prefrences.dart';
import 'package:visitor_management/visitor/venue_screen.dart';
import 'auth.dart';
import 'package:visitor_management/admin/admin_screen_tabs.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});

  BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  initState() {
    super.initState();
    widget.auth = new Auth();
  }

  BuildContext scaffoldContext;
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  bool visitorVal = false;
  bool adminVal = false;

  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    FirebaseUser user;
    String userId;

    if (_validateAndSave()) {
      try {
        userId =
            await widget.auth.signInWithEmailAndPassword(_email, _password);

        widget.onSignedIn();
      } catch (e) {
        //onError

      }
    }
  }

  BaseAuth auth;
  VoidCallback onSignedOut;
  VoidCallback onSignedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Login"),
        ),
        body: Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset("assets/logo.png")),
                    new TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Email",
                        labelText: "Email",
                      ),
                      validator: (value) =>
                          value.isEmpty ? "Email cant be empty" : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value.isEmpty ? "Password cant be empty" : null,
                      onSaved: (value) => _password = value,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Visitor"),
                              Checkbox(
                                value: visitorVal,
                                onChanged: (bool value) {
                                  addAdminBoolToSF(false);

                                  addVisitorBoolToSF(
                                      true); //on checkingbox setting visitor bool  values toshared prefrence do that on app restart i can navigate to appropriate screen visitor or admin
                                  setState(() {
                                    if (value == true) {
                                      adminVal = false;
                                    }
                                    print("admin value: $adminVal");

                                    visitorVal = value;
                                    print("visitor value: $visitorVal");
                                  });
                                },
                              ),
                            ],
                          ), // [Tuesday] checkbox
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Admin"),
                              Checkbox(
                                value: adminVal,
                                onChanged: (bool value) {
                                  addAdminBoolToSF(true);

                                  addVisitorBoolToSF(
                                      false); //read above comment for information

                                  setState(() {
                                    if (value == true) {
                                      visitorVal = false;
                                    }
                                    print("visitor value: $visitorVal");

                                    adminVal = value;
                                    print("admin value: $adminVal");
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ButtonTheme(
                        height: 50.0,
                        child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: new Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              if (visitorVal == true) {
                                _signInAsVisitor();
                              }
                              if (adminVal == true) {
                                _signInAsAdmin();
                              }
                            }),
                      ),
                    )
                  ],
                )),
          );
        }));
  }

  void _signInAsVisitor() async {
    FirebaseUser user;

    if (_validateAndSave()) {
      showLoginFloatingFlushbar(context);
      try {
        user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } catch (e) {
        print("error signing in The ERROR IS ${e}");

        showErrorFloatingFlushbar(context);
      }

      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VenueScreen(
                    onsignedOut: onSignedOut,
                    auth: auth,
                  )),
        );
        print("SIGNED AS USER: ${user.uid}");
      }
    }
  }

  void _signInAsAdmin() async {
    FirebaseUser user;

    if (_validateAndSave()) {
      showLoginFloatingFlushbar(context);
      try {
        user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } catch (e) {
        print("error signing in The ERROR IS ${e}");

        showErrorFloatingFlushbar(context);
      }

      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPortal()));

        print("SIGNED AS USER: ${user.uid}");
      }
    }
  }

  void showLoginFloatingFlushbar(BuildContext context) {
    Flushbar(
      backgroundColor: Colors.orange,
      margin: EdgeInsets.all(5),
      showProgressIndicator: true,
      duration: Duration(seconds: 4),
      progressIndicatorBackgroundColor: Colors.white,
      animationDuration: Duration(seconds: 2),

      borderColor: Colors.white,
      isDismissible: true,
      padding: EdgeInsets.all(10.0),

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
      title: 'Logging In..',
      message: 'as visitor end',
    ).show(context);
  }

  void showErrorFloatingFlushbar(BuildContext context) {
    Flushbar(
      backgroundColor: Colors.orange,
      icon: Icon(Icons.error),

      margin: EdgeInsets.all(5.0),

      borderRadius: 5.0,
      duration: Duration(seconds: 4),
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
        "Enter correct credentials",
        style: TextStyle(color: Colors.white),
      ),
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Error Logging In..',
      message: 'please try again',
    ).show(context);
  }
}
