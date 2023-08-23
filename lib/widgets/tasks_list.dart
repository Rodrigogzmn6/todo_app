import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_tile.dart';
import 'package:todo_app/providers/theme_provider.dart';

import '../providers/user_provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return FutureBuilder<dynamic>(
      future: userProvider.tasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text("error");
        } else {
          return Card(
            elevation: 0,
            shadowColor: themeProvider.backgroundColor,
            color: themeProvider.backgroundColor,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskTile(
                  task: snapshot.data![index]["text"],
                  isChecked: snapshot.data![index]["isChecked"],
                  id: snapshot.data![index]["id"],
                );
              },
              itemCount: snapshot.data!.length,
            ),
          );
        }
      },
    );
  }
}
