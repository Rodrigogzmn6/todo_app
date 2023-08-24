import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/user_provider.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String task;
  final String id;

  const TaskTile(
      {super.key,
      required this.isChecked,
      required this.task,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return CheckboxListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: themeProvider.backgroundColor)),
      tileColor: themeProvider.itemBackgroundColor,
      value: isChecked,
      onChanged: (value) async {
        try {
          await userProvider.checkTask(value, id);
        } catch (e) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(
              description: e is FirebaseAuthException
                  ? e.message.toString()
                  : e.toString(),
            ),
            barrierDismissible: true,
          );
        }
      },
      title: Text(
        task,
        style: isChecked
            ? TextStyle(
                color: themeProvider.checkedTextColor,
                fontSize: 20.0,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2.0,
              )
            : TextStyle(
                color: themeProvider.textColor,
                fontSize: 20.0,
              ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: GestureDetector(
        onTap: () async {
          try {
            await userProvider.removeTask(id);
          } catch (e) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(
                description: e is FirebaseAuthException
                    ? e.message.toString()
                    : e.toString(),
              ),
              barrierDismissible: true,
            );
          }
        },
        child: Icon(
          Icons.close_rounded,
          color: themeProvider.checkedTextColor,
        ),
      ),
    );
  }
}
