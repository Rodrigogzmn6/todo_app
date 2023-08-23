import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/form_layout.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_frame.dart';
import 'package:todo_app/components/rounded_button.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    navigateToRoute(route) => Navigator.pushNamed(context, '$route');

    return MainFrame(
      childWidget: Center(
        child: FormLayout(
          formFields: [
            RoundedButton(
              backgroundColor: themeProvider.backgroundColor,
              borderColor: themeProvider.itemBackgroundColor,
              textColor: themeProvider.textColor,
              title: 'Login',
              handleOnPressed: () => navigateToRoute('/login'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              backgroundColor: themeProvider.itemBackgroundColor,
              borderColor: themeProvider.itemBackgroundColor,
              textColor: themeProvider.textColor,
              title: 'Register',
              handleOnPressed: () => navigateToRoute('/register'),
            ),
          ],
        ),
      ),
    );
  }
}
