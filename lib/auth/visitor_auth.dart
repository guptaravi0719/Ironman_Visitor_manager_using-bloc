import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitor_management/visitor/venue_screen.dart';
import 'auth.dart';

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

  bool loading = false;
  bool snackbarlogin = false;
  BuildContext scaffoldContext;
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

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
//        user = await FirebaseAuth.instance
//            .signInWithEmailAndPassword(email: _email, password: _password);

        widget.onSignedIn();
      } catch (e) {
        setState(() {
          snackbarlogin = true;
        });
        print("error signing in The ERROR IS ${e}");

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.

      }

      if (userId != null) {
        setState(() {
          loading = false;
        });
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => VenueScreen()),
//        );
        print("SIGNED AS USER: ${user.uid}");
      } else {
        // print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
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
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              //  validateAndSubmit();

                              FirebaseUser user;

                              if (_validateAndSave()) {
//                                Scaffold.of(context)
//                                  ..hideCurrentSnackBar()
//                                  ..showSnackBar(
//                                    SnackBar(
//                                      content: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Text('Loading...'),
//                                          CircularProgressIndicator()
//                                        ],
//                                      ),
//                                      backgroundColor: Colors.black,
//                                    ),
//                                  );
                              showLoginFloatingFlushbar(context);
                                try {
                                  setState(() {
                                    // loading = true;
                                  });
                                  user = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _email, password: _password);
                                } catch (e) {
                                  setState(() {
                                    // loading = false;
                                    snackbarlogin = true;
                                  });
                                  print("error signing in The ERROR IS ${e}");

//                                  Scaffold.of(context)
//                                    ..hideCurrentSnackBar()
//                                    ..showSnackBar(
//                                      SnackBar(
//                                        content: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: [
//                                            Text('Login Failure'),
//                                            Icon(Icons.error)
//                                          ],
//                                        ),
//                                        backgroundColor: Colors.red,
//                                      ),
//                                    );
                                showErrorFloatingFlushbar(context);

                                  // Find the Scaffold in the widget tree and use
                                  // it to show a SnackBar.

                                }

                                if (user != null) {
                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VenueScreen(
                                              onsignedOut: onSignedOut,
                                              auth: auth,
                                            )),
                                  );
                                  print("SIGNED AS USER: ${user.uid}");
                                } else {
                                  print(
                                      "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
                                }
                              }
                            }),
                      ),
                    )
                  ],
                )),
          );
        })

    );
  }
  void showLoginFloatingFlushbar(BuildContext context) {
    Flushbar(backgroundColor: Colors.orange,
      margin: EdgeInsets.all(8),
      showProgressIndicator: true,
      duration: Duration(seconds: 4),
      borderRadius: 5.0,
      animationDuration: Duration(seconds: 2),

      borderColor: Colors.white,isDismissible: true,
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
    Flushbar(backgroundColor: Colors.orange,
      icon:Icon(Icons.error),
      margin: EdgeInsets.all(5.0),
      borderRadius: 5.0,
      duration: Duration(seconds: 4),
      animationDuration: Duration(seconds: 2),

      borderColor: Colors.white,isDismissible: true,
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
      messageText: Text("Enter correct credentials",style: TextStyle(color: Colors.white),),
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

