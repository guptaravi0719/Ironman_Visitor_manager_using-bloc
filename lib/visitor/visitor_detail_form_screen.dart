import 'package:flutter/material.dart';
import 'package:visitor_management/data_to_be_added';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VisitorDetailForm extends StatefulWidget {
  @override
  _VisitorDetailFormState createState() => _VisitorDetailFormState();
}

class _VisitorDetailFormState extends State<VisitorDetailForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String _name;
  String _person_to_meet;
  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {

    var now= new DateTime.now();



    if (_validateAndSave()) {

      data_to_add['name']=_name;
      data_to_add['person_to_meet']=_person_to_meet;
      data_to_add['time']=DateFormat("H:m:s").format(now);


      Firestore.instance.collection('/locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/visitors').add(data_to_add).catchError(onError);


  }}
onError(){
    print("Error Dutnd CCCCCCCCCCCCRRRRRRRRRRRRRUUUUUUUUUDDDDDDDDDDDDD");

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(title: Text("Details"),),
      body:
      new Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(
                  labelText: "name",
                ),
                validator: (value) =>
                value.isEmpty ? "Please enter your name" : null,
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "person  name"),
                obscureText: true,
                validator: (value) =>
                value.isEmpty ? "Enter the meeting person" : null,
                onSaved: (value) => _person_to_meet= value,
              ),
              RaisedButton(
                  child: new Text("Submit"),
                  onPressed: () async {
                     _validateAndSubmit();



                    if (_validateAndSave()) {
                      _scaffoldKey.currentState
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Entering you in..'),
                                CircularProgressIndicator()
                              ],
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );



                    }
                  })
            ],
          )),

    );
  }
}
