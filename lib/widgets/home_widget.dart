import 'package:flutter/material.dart';
import 'package:todo_app/widgets/filters.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:todo_app/widgets/new_task.dart';
import 'package:todo_app/widgets/tasks_list.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainFrame(
      logoutIcon: true,
      childWidget: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            NewTask(),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: TasksList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Filters(),
          ],
        ),
      ),
    );
  }
}
