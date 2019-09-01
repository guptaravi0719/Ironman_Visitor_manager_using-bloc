
import 'package:shared_preferences/shared_preferences.dart';

import 'location.dart';

addStringToSF(String selectedLocation) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('location' ,selectedLocation);//setting location string to desired location in flutter shared prefrences
}

Future<String> getValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
   return prefs.getString('location');
  //Return bool

}