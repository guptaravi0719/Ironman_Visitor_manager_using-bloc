import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:visitor_management/main.dart';
Future<bool> uploadingImageDialogue(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Please Wait..."),

            content:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[



              Text("uploading"),
              CircularProgressIndicator()


            ],)

        );
      });
}