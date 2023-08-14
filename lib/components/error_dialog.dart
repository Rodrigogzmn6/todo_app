import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String title, description;
  const ErrorDialog(
      {super.key, this.title = Constants.errorMessage, this.description = ""});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error_rounded,
      ),
      iconColor: Colors.redAccent,
      title: const Text(
        "Ups! Something went wrong.",
        style: TextStyle(color: Constants.dkTextColor),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Constants.dkTextColor),
      ),
      backgroundColor: Constants.dkItemBackgroundColor,
    );
  }
}
