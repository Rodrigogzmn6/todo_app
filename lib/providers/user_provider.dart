import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/constants.dart';

class UserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  get user => _auth.currentUser;

  loginUser(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  registerUser(name, lastname, email, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection(Constants.collection).add({
        "name": name.trim(),
        "lastname": lastname.trim(),
        "email": email,
        "tasks": Constants.dummyTasks,
      });
    } on Exception catch (e) {
      // TODO
    }
  }
}
