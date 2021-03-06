import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:visitor_management/data_to_be_added';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:visitor_management/settings/location.dart';
import 'package:visitor_management/visitor/page_route.dart';
import 'package:visitor_management/visitor/welcome_screen.dart';

class VisitorDetailForm extends StatefulWidget {
  String category;

  VisitorDetailForm({this.category});

  @override
  _VisitorDetailFormState createState() => _VisitorDetailFormState();
}

class _VisitorDetailFormState extends State<VisitorDetailForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String _name;
  String _no_of_guests;
  String _person_to_meet;
  String _address;
  String _purpose;
  List<String > _purposeList=[
    'Interview',
    'Training',
    'Personal',
    'Official',
    'Other'
    ,
    'hub tour'

  ];

  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    var now = new DateTime.now();

    if (_validateAndSave()) {
      var no_of_guests=_no_of_guests!=null?"1":_no_of_guests; // seting default value of guest to 1
      data_to_add['name'] = _name;
      data_to_add['no_of_guests'] = no_of_guests;   //if no entry rhen pushing 0
      data_to_add['person_to_meet'] = _person_to_meet;
      data_to_add['time'] = DateFormat("H:m:s").format(now);
      data_to_add['address']=_address;
      data_to_add['purpose']=_purpose;

      try {
        Firestore.instance
            .collection(
                '/locations/$location/people/${DateFormat("dd-MM-yyyy").format(now)}/${widget.category}')
            .add(data_to_add);
        _showFloatingFlushbar(context);

          Navigator.pushReplacement(
            context,
            SlideRightRoute(widget: WelcomeScreen()),

          );
          data_to_add.clear();

      } catch (e) {
        print("ERROR ON SAVING ON FIRESTORE");
      }
    }
  }

  onError() {
    print("Error Dutnd CCCCCCCCCCCCRRRRRRRRRRRRRUUUUUUUUUDDDDDDDDDDDDD");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: new Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Image.asset("assets/person.png"),
                ),
                new TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Name",
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Please enter your Name" : null,
                  onSaved: (value) => _name = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: "Host Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Host name can't be empty" : null,
                  onSaved: (value) => _person_to_meet = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                //  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:"No.of guests",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
//                  validator: (value) =>
//                      value.isEmpty ? "no. of guests can't be empty" : null,
                  onSaved: (value) => _no_of_guests = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
        Center(
          child: SizedBox(
            height: 50.0,
            width: MediaQuery.of(context).size.width-60,
            child: DropdownButton(
              hint: Text('Please choose purpose'), // Not necessary for Option 1
              value: _purpose,
              onChanged: (newValue) {
                setState(() {
                  _purpose = newValue;
                });
              },
              items: _purposeList.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
          ),
        ),

                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  //  textCapitalization: TextCapitalization.sentences,

                  decoration: InputDecoration(
                    labelText:"address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) =>
                  value.isEmpty ? "Address can't be empty" : null,
//                  validator: (value) =>
//                      value.isEmpty ? "no. of guests can't be empty" : null,
                  onSaved: (value) => _address = value,
                ),
                SizedBox(
                  height: 30.0,
                ),
                ButtonTheme(
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,30),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                     // borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: new Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
//                        if (_validateAndSave()) {
//                          _showFloatingFlushbar(context);
//
//
//                        }
                          _validateAndSubmit();
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _showFloatingFlushbar(BuildContext context) {
    Flushbar(
      backgroundColor: Colors.orange,
      margin: EdgeInsets.all(8),
      showProgressIndicator: true,
      duration: Duration(seconds: 4),
      borderRadius: 5.0,
      animationDuration: Duration(seconds: 2),
      isDismissible: true,
      padding: EdgeInsets.all(8.0),

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
      title: '91 SPRINGBOARD ',
      message: "Welcome",
    ).show(context);
  }
}
