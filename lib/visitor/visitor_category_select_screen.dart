import 'package:flutter/material.dart';
import 'package:fluttertoast/generated/i18n.dart';
import 'package:visitor_management/auth/extra_dummy/mobile_verification_screen.dart';
import 'package:visitor_management/auth/phone_auth_Screen.dart';
import 'package:visitor_management/visitor/exit_section/exit_screen_tabs.dart';
import 'package:visitor_management/visitor/venue_screen.dart';
import 'package:visitor_management/visitor/page_route.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VenueScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
              child: Text(
                "Select Category",
                style: TextStyle(
                  color: Colors.black54,
                    fontSize: 20.0,

                    fontWeight: FontWeight.bold),
              ),
            )),
            Container(
              height: 50.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Visitor",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhoneAuthScreen(category: "visitors")),
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              width: 100,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Vendor",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhoneAuthScreen(category: "vendors")),
                  );
                },
                color:Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "91 Lead",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhoneAuthScreen(category: "91Lead")),
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Courier",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhoneAuthScreen(category: "couriers")),
                  );
                },
                color:Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Day Pass",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhoneAuthScreen(category: "daypass")),
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                color: Colors.blue,

                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "Exit Timings",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ExitScreenTabs()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
