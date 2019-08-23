import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitor_management/root_page.dart';

import 'auth/visitor_auth.dart';
import 'auth/auth.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange,


      ),
      title: "Visitors",
      home: RootPage(
        auth: new Auth(),
      ),
    );
  }
}
