import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

import '../constants.dart';

class CustomFormField extends StatelessWidget {
  final String placeholder;
  final Function handleOnChange;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomFormField({
    super.key,
    required this.placeholder,
    required this.handleOnChange,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TextField(
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      obscureText: obscureText,
      onChanged: (value) => handleOnChange(value),
      style: TextStyle(
        color: themeProvider.textColor,
        fontSize: 20.0,
      ),
      decoration: Constants.formTextFieldDecoration.copyWith(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: themeProvider.checkedTextColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: themeProvider.itemBackgroundColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: themeProvider.itemBackgroundColor, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
