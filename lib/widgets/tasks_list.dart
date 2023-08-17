import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_tile.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/theme_provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List tasks = [];

  void retrieveTasks() async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _auth.currentUser?.email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          tasks = snapshot.docs[0].data()["tasks"];
        });
      } else {
        print("no docs");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return tasks.isEmpty
        ? Container()
        : Card(
            elevation: 0,
            shadowColor: themeProvider.backgroundColor,
            color: themeProvider.backgroundColor,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index]["text"],
                  isChecked: tasks[index]["isChecked"],
                );
              },
              itemCount: 10,
            ),
          );
  }
}
