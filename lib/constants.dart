import 'package:flutter/material.dart';

class Constants {
  // * Colors
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

  // * Strings
  // * Forms
  static const namePlaceholder = 'Enter your name';
  static const lastnamePlaceholder = 'Enter your last name';
  static const emailPlaceholder = 'example@test.com';
  static const passwordPlaceholder = 'Enter your password';

  // * Decorations
  static const formTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: dkCheckedTextColor),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: dkItemBackgroundColor, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: dkItemBackgroundColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
