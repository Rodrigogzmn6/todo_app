import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String task;

  const TaskTile({super.key, required this.isChecked, required this.task});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Constants.dkBackgroundColor)),
      tileColor: Constants.dkItemBackgroundColor,
      value: isChecked,
      onChanged: (value) => print("hola"),
      title: Text(
        task,
        style: const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: GestureDetector(
        onTap: () => {print("Delete task")},
        child: const Icon(
          Icons.close_rounded,
          color: Constants.dkCheckedTextColor,
        ),
      ),
    );
  }
}
