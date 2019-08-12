import 'package:flutter/material.dart';
import 'package:visitor_management/auth/auth.dart';
import 'package:visitor_management/auth/visitor_auth.dart';
import 'package:visitor_management/visitor/venue_screen.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((userId) {

      setState(() {
        authStatus= userId==null? AuthStatus.notSignedIn:AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
       break;
      case AuthStatus.signedIn:
        return VenueScreen(
          auth: widget.auth,
          onsignedOut: _signedOut,
        );
        break;
    }
  }
}
