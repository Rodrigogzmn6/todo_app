import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool isChecked = false;
  String task = "";
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  void handleSaveTask() async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        print(snapshot.docs[0].data());
        var docId = snapshot.docs[0].id;
        List newTasks = snapshot.docs[0].data()["tasks"];
        newTasks.add({"text": task, "isChecked": isChecked});

        print(docId + newTasks.toString());

        await _firestore
            .collection("users")
            .doc(docId)
            .update({"tasks": newTasks});

        setState(() {
          _controller.clear();
          _focusNode.unfocus();
          isChecked = false;
        });
      } else {
        print("no docs");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: Constants.dkItemBackgroundColor,
      value: isChecked,
      onChanged: (value) => setState(() {
        isChecked = value!;
      }),
      title: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (value) => task = value,
        style: const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
        decoration: Constants.newTaskFieldDecoration
            .copyWith(hintText: Constants.newTaskPlaceholder),
      ),
      secondary: GestureDetector(
        onTap: handleSaveTask,
        child: const Icon(
          Icons.save_alt_rounded,
          color: Constants.dkTextColor,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: const CircleBorder(),
    );
  }
}
