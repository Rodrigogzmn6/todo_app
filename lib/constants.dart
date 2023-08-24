import 'package:flutter/material.dart';

class Constants {
  //! COLORS
  // * Title and active
  static const activeTextColor = Color(0xFF4773D8);
  static const titleTextColor = Color(0xFFFFFFFF);

  // * Dark theme
  static const dkBackgroundColor = Color(0xFF181824);
  static const dkItemBackgroundColor = Color(0xFF25273C);
  static const dkTextColor = Color(0xFFFFF9FF);
  static const dkCheckedTextColor = Color(0xFF494B62);

  // * Light theme
  static const lgBackgroundColor = Color(0xFFFAFAFA);
  static const lgItemBackgroundColor = Color(0xFFFFFFFF);
  static const lgTextColor = Color(0xFF4D4E5C);
  static const lgCheckedTextColor = Color(0xFFC4C3C9);

  //! STRINGS
  // * Assets
  static const darkBackgroundImage = "assets/bg-mobile-dark.jpg";
  static const lightBackgroundImage = "assets/bg-mobile-light.jpg";

  // * Buttons
  static const login = 'Log In';
  static const register = 'Register';

  // * Collection Name
  static const collection = 'users';

  // * Error messages
  static const errorMessage = "Ups! Something went wrong.";
  static const blankName = "Please fill the name field";
  static const blankLastName = "Please fill the last name field";
  static const blankEmail = "Please fill the email field";
  static const blankPassword = "Please fill the password field";
  static const linkError = "Couldn't open link";

  // * Filteres
  static const all = "All";
  static const active = "Active";
  static const completed = "Completed";

  // * Forms
  static const namePlaceholder = 'Enter your name';
  static const lastnamePlaceholder = 'Enter your last name';
  static const emailPlaceholder = 'example@test.com';
  static const passwordPlaceholder = 'Enter your password';
  static const newTaskPlaceholder = 'Do the dishes';

  // * Repository link
  static const repoLink = 'https://github.com/Rodrigogzmn6';

  // * Routes
  static const homeRoute = '/';
  static const loginRoute = '/login';
  static const registerRoute = '/register';

  // * Themes
  static const darkTheme = 'dark';
  static const lightTheme = 'light';

  // * DECORATIONS
  static const formTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: dkCheckedTextColor),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
  static const newTaskFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: dkCheckedTextColor),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
  );

  // * DUMMY TASK
  static List<Map<String, dynamic>> dummyTasks = [
    {"isChecked": false, "text": "Buy milk", "id": 1},
    {"isChecked": false, "text": "Go to the gym", "id": 2},
    {"isChecked": false, "text": "Clean the room", "id": 3},
  ];
}
