import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String enail, String password) {}

  Future<String> currentUser() {}
  Future<void> signOut() {}
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> signInWithEmailAndPassword(
      String enail, String password) async {
    //TODO: implement signInWithEmailAndPassword

    FirebaseUser user = await _firebaseAuth.currentUser();

    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut

    return _firebaseAuth.signOut();
  }
}
