import 'package:flutter/material.dart';
import 'package:visitor_management/visitor/page_route.dart';
import 'package:visitor_management/visitor/visitor_category_select_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset("assets/logo_horizontal.png"),
          ),
          SizedBox(
            child: Image.asset("assets/welcome_flower.png"),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 2,
          ),
          Center(
            child: Text(
              "WELCOME",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 30.0),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "More Visitors",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                      SlideRightRoute(
                       widget:VisitorCategorySelectScreen()),
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
