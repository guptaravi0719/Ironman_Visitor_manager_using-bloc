
import 'package:shared_preferences/shared_preferences.dart';

import 'location.dart';

addStringLocationToSF(String selectedLocation) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('location' ,selectedLocation);//setting location string to desired location in flutter shared prefrences
}

Future<String> getLocationValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
   return prefs.getString('location');
  //Return bool

}

addVisitorBoolToSF(bool visitorBool) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('visitor' ,visitorBool);//setting location string to desired location in flutter shared prefrences
}

Future<bool> getVisitorBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  return prefs.getBool('visitor');
  //Return bool

}
addAdminBoolToSF(bool visitorBool) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('admin' ,visitorBool);//setting location string to desired location in flutter shared prefrences
}

Future<bool> getAdminBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  return prefs.getBool('admin');
  //Return bool

}
