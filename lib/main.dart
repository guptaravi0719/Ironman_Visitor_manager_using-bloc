import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitor_management/root_page.dart';
import 'package:visitor_management/settings/location.dart';
import 'package:visitor_management/settings/location_shared_prefrences.dart';

import 'auth/visitor_auth.dart';
import 'auth/auth.dart';
import 'package:visitor_management/visitor/venue_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    futureLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange[300],


      ),
      title: "Visitors",
      home: RootPage(
        auth: new Auth(),
      ),
    );
  }

  futureLocation() {
    getValuesSF().then((value) {
      setState(() {
        location = value;
      });
    }


    );
  }
}


