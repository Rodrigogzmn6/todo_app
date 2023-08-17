import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String task;

  const TaskTile({super.key, required this.isChecked, required this.task});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: themeProvider.backgroundColor)),
      tileColor: themeProvider.itemBackgroundColor,
      value: isChecked,
      onChanged: (value) => print("hola"),
      title: Text(
        task,
        style: TextStyle(color: themeProvider.textColor, fontSize: 20.0),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: GestureDetector(
        onTap: () => {print("Delete task")},
        child: Icon(
          Icons.close_rounded,
          color: themeProvider.checkedTextColor,
        ),
      ),
    );
  }
}
