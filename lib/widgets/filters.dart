import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_tile.dart';
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
              "All",
              style: TextStyle(
                color: userProvider.filter == "All"
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = ("All"),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              "Active",
              style: TextStyle(
                color: userProvider.filter == "Active"
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = ("Active"),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              "Completed",
              style: TextStyle(
                color: userProvider.filter == "Completed"
                    ? Constants.activeTextColor
                    : themeProvider.textColor,
              ),
            ),
            onTap: () => userProvider.filter = "Completed",
          ),
        ],
      ),
    );
  }
}
