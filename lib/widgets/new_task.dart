import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/constants.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  NewTaskState createState() => NewTaskState();
}

class NewTaskState extends State<NewTask> {
  bool isChecked = false;
  String task = "";
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return CheckboxListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: themeProvider.itemBackgroundColor,
      value: isChecked,
      onChanged: (value) => setState(() {
        isChecked = value!;
      }),
      title: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (value) => task = value,
        style: TextStyle(
          color: themeProvider.textColor,
          fontSize: 20.0,
        ),
        decoration: Constants.newTaskFieldDecoration.copyWith(
          hintText: Constants.newTaskPlaceholder,
        ),
      ),
      secondary: GestureDetector(
        onTap: () async {
          try {
            await userProvider.addTask(task, isChecked);
            setState(() {
              _controller.clear();
              _focusNode.unfocus();
              isChecked = false;
            });
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
          Icons.save_alt_rounded,
          color: themeProvider.textColor,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: const CircleBorder(),
    );
  }
}
