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
                                Scaffold.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Loading...'),
                                          CircularProgressIndicator()
                                        ],
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                  );
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

                                  Scaffold.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Login Failure'),
                                            Icon(Icons.error)
                                          ],
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

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
        }));
  }
}

//import 'dart:async';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:visitor_management/visitor/venue_screen.dart';
//class VisitorAuth extends StatefulWidget {
//  @override
//  _VisitorAuthState createState() => _VisitorAuthState();
//}
//TextEditingController _emailController = TextEditingController();
//TextEditingController _passwordController = TextEditingController();
//
//class _VisitorAuthState extends State<VisitorAuth> {
//  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
//  var _email;
//  var _password;
//bool loading=false;
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      body: loading==false?Center(
//        child: ListView(
//          children: <Widget>[
//            Column(children: <Widget>[
//              SizedBox(height:
//              MediaQuery.of(context).size.height/2.5,)
//         , TextField(
//                controller:_emailController,
//                onChanged: (value){
//                  setState(() {
//                    _email=value;
//                  });
//
//                },
//
//              ),
//            TextField(controller: _passwordController,
//
//              onChanged: (value){
//                setState(() {
//                  _password =value;
//                });
//
//
//              },
//            ),
//              RaisedButton(
//                onPressed: () async{
//                  setState(() {
//                    loading=true;
//                  });
//
//                  Map<String,dynamic> successInformation;
//
//                  successInformation=  await  login(_email,_password);
//
//
//                  if (successInformation['success']){
//                    setState(() {
//                      loading=false;
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => VenueScreen()),
//                      );
//
//                    });
//
//
//                  }
//                  else{
//                    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX") ;
//                  }
//
//
//                }
////                onPressed: (){
////                  setState(() {
////                    loading=true;
////                  });
////             FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password:_password).then((onValue){
////
////               FirebaseUser user;
////         debugPrint("Logged in");
////               Navigator.push(
////                 context,
////                 MaterialPageRoute(builder: (context) =>VenueScreen()),
////               );
////
////
////               setState(() {
////                 loading=false;
////               });
////             });
////
////
////
////                },
//
//
//              )
//
//
//            ],),
//          ],
//        ),
//      ):Center(child: CircularProgressIndicator(),)
//    );
//
//  }
////  Future<void> signIn() async {
////  final formState=_formKey.currentState;
////  //if(formState.validate()){
//// // formState.save();
////
////  AuthResult result;
////  try {
////    setState(() {
////      loading=true;
////    });
////
////
////    result = await FirebaseAuth.instance.signInWithEmailAndPassword(
////        email: _email, password: _password).then(onValue);
////
////    FirebaseUser user = result.user;
////  }catch(e){
////
////print(e.toString());
////
////  }
//
//
// // FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//  //}
// // }
//
//Future<Map<String,dynamic>> login(String email,String password) async {
//
//    final Map<String,dynamic> authData={
//'email':email,
//      'password':password,
//'returnSecureToken': true
//  };
//    final http.Response response= await http.post(
//
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyCyZNLZLq32Aq3rWs_bKIiB392lHzf9DqM ',
//body: json.encode(authData),
//  headers: {'content-Type':'application/json'}
//
//    );
//
//final Map<String,dynamic> responseData=json.decode(response.body);
//bool hasError=true;
//String message='something went wrong';
//if (responseData.containsKey('idToken')){
//  hasError=false;
//  message='Authentication Succeded';
//}
//else if (responseData['error']['message']=='EMAIL_EXISTS'){
//  message='This email already exists';
//
//}
//else if(responseData['error']['message']== 'INVALID_PASSWORD'){
//  message='The password is invalid';
//
//}
//return {'success':!hasError,'message':message};
//
//
//
//}
//
//}
//
//
