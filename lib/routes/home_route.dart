import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/widgets/home_widget.dart';
import 'package:todo_app/widgets/welcome_widget.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.currentUser != null
        ? const HomeWidget()
        : const WelcomeWidget();
  }
}
