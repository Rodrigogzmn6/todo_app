import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor, textColor, borderColor;
  final String title;
  final Function handleOnPressed;

  const RoundedButton({
    super.key,
    this.backgroundColor = Constants.activeTextColor,
    this.textColor = Constants.dkTextColor,
    this.borderColor = Constants.dkItemBackgroundColor,
    required this.title,
    required this.handleOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      color: backgroundColor,
      onPressed: () => handleOnPressed(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
