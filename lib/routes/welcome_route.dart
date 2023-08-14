import 'package:flutter/material.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import '../widgets/main_frame.dart';
import 'package:todo_app/components/rounded_button.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToRoute(route) => Navigator.pushNamed(context, '$route');

    return MainFrame(
      childWidget: FormLayout(
        formFields: [
          RoundedButton(
            title: 'Login',
            handleOnPressed: () => navigateToRoute('/login'),
          ),
          const SizedBox(
            height: 24.0,
          ),
          RoundedButton(
            backgroundColor: Constants.dkItemBackgroundColor,
            title: 'Register',
            handleOnPressed: () => navigateToRoute('/register'),
          ),
        ],
      ),
    );
  }
}
