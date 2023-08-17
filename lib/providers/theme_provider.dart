import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class ThemeProvider with ChangeNotifier {
  String _theme = 'dark';
  Color _backgroundColor = Constants.dkBackgroundColor;
  Color _itemBackgroundColor = Constants.dkItemBackgroundColor;
  Color _textColor = Constants.dkTextColor;
  Color _checkedTextColor = Constants.dkCheckedTextColor;

  String get theme => _theme;
  Color get backgroundColor => _backgroundColor;
  Color get itemBackgroundColor => _itemBackgroundColor;
  Color get textColor => _textColor;
  Color get checkedTextColor => _checkedTextColor;

  set theme(theme) {
    _theme = theme;
    if (_theme == 'dark') {
      _backgroundColor = Constants.dkBackgroundColor;
      _itemBackgroundColor = Constants.dkItemBackgroundColor;
      _textColor = Constants.dkTextColor;
      _checkedTextColor = Constants.dkCheckedTextColor;
    } else {
      _backgroundColor = Constants.lgBackgroundColor;
      _itemBackgroundColor = Constants.lgItemBackgroundColor;
      _textColor = Constants.lgTextColor;
      _checkedTextColor = Constants.lgCheckedTextColor;
    }
    notifyListeners();
  }
}
