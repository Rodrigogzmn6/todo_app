import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class MainFrame extends StatelessWidget {
  const MainFrame({super.key, required this.childWidget});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg-mobile-dark.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Constants.titleTextColor),
        title: const Text(
          "TODO",
          style: TextStyle(color: Constants.titleTextColor, fontSize: 32.0),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: const Icon(
                Icons.sunny,
                size: 26.0,
                color: Constants.titleTextColor,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Constants.dkBackgroundColor,
      body: Center(
        child: childWidget,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
