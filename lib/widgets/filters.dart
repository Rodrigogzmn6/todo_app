import 'package:flutter/material.dart';
import 'package:todo_app/components/task_tile.dart';
import 'package:todo_app/constants.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: Constants.dkItemBackgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: const Text(
              "All",
              style: TextStyle(
                color: Constants.dkTextColor,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: const Text(
              "Active",
              style: TextStyle(
                color: Constants.dkTextColor,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            child: const Text(
              "Completed",
              style: TextStyle(
                color: Constants.dkTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
