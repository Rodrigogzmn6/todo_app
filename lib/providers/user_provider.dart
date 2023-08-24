import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/constants.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uu';

class UserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();
  List _tasks = [];
  String _filter = "All";

  get currentUser => _auth.currentUser;
  get filter => _filter;
  get tasks async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        if (_filter == "Active") {
          _tasks = snapshot.docs[0]
              .data()["tasks"]
              .where((task) => task["isChecked"] == false)
              .toList();
        } else if (_filter == "Completed") {
          _tasks = snapshot.docs[0]
              .data()["tasks"]
              .where((task) => task["isChecked"] == true)
              .toList();
        } else {
          _tasks = snapshot.docs[0].data()["tasks"];
        }
        return _tasks;
      } else {
        throw ("User not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  loginUser(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
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
        "email": email.trim(),
        "tasks": [
          {"isChecked": false, "text": "Buy milk", "id": _uuid.v4()},
          {"isChecked": false, "text": "Go to the gym", "id": _uuid.v4()},
          {"isChecked": false, "text": "Clean the room", "id": _uuid.v4()},
        ],
      });
    } catch (e) {
      rethrow;
    }
  }

  signOutUser() async {
    await _auth.signOut();
    notifyListeners();
  }

  addTask(text, checked) async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var docId = snapshot.docs[0].id;
        _tasks = snapshot.docs[0].data()["tasks"];
        _tasks.add({"text": text, "isChecked": checked, "id": _uuid.v4()});

        await _firestore
            .collection("users")
            .doc(docId)
            .update({"tasks": _tasks});
        notifyListeners();
      } else {
        throw ("We couldn't find any task list.");
      }
    } catch (e) {
      rethrow;
    }
  }

  removeTask(id) async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var docId = snapshot.docs[0].id;
        _tasks = snapshot.docs[0].data()["tasks"];
        _tasks.removeWhere((task) => task["id"] == id);

        await _firestore
            .collection("users")
            .doc(docId)
            .update({"tasks": _tasks});
        notifyListeners();
      } else {
        throw ("We couldn't find any task list.");
      }
    } catch (e) {
      rethrow;
    }
  }

  checkTask(value, id) async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var docId = snapshot.docs[0].id;
        _tasks = snapshot.docs[0].data()["tasks"];
        for (var task in _tasks) {
          if (task["id"] == id) {
            task["isChecked"] = value;
          }
        }

        await _firestore
            .collection("users")
            .doc(docId)
            .update({"tasks": _tasks});
        notifyListeners();
      } else {
        throw ("We couldn't find any task list.");
      }
    } catch (e) {
      rethrow;
    }
  }

  set filter(filter) {
    _filter = filter;
    notifyListeners();
  }
}
