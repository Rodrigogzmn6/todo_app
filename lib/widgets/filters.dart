import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/user_provider.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: themeProvider.itemBackgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Text(
              Constants.all,
              style: TextStyle(
                color: userProvider.filter == Constants.all
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = (Constants.all),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              Constants.active,
              style: TextStyle(
                color: userProvider.filter == Constants.active
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = (Constants.active),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              Constants.completed,
              style: TextStyle(
                color: userProvider.filter == Constants.completed
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = Constants.completed,
          ),
        ],
      ),
    );
  }
}
