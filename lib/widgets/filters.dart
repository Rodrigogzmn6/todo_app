import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/task_tile.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/theme_provider.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                color: themeProvider.textColor,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              "Active",
              style: TextStyle(
                color: themeProvider.textColor,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: Text(
              "Completed",
              style: TextStyle(
                color: themeProvider.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
