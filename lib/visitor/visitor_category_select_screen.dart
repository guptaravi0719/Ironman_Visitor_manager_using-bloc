import 'package:flutter/material.dart';
import 'package:visitor_management/auth/phone_auth_Screen.dart';

class VisitorCategorySelectScreen extends StatefulWidget {
  @override
  _VisitorCategorySelectScreenState createState() =>
      _VisitorCategorySelectScreenState();
}

class _VisitorCategorySelectScreenState
    extends State<VisitorCategorySelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Categories")

    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text("Visitor"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen()),
                );

              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Vendor"),
              onPressed: (){


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("91 Lead"),
              onPressed: (){


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Couries"),
              onPressed: (){


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),


            RaisedButton(
              child: Text("Day Pass"),
              onPressed: (){


              },
              color: Colors.orange,
            ),
            SizedBox(height: 30.0,),





          ],


        ),
      ),


    );
  }
}
