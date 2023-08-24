import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_frame.dart';
import 'package:todo_app/components/rounded_button.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MainFrame(
      childWidget: Center(
        child: FormLayout(
          formFields: [
            RoundedButton(
              backgroundColor: themeProvider.backgroundColor,
              borderColor: themeProvider.itemBackgroundColor,
              textColor: themeProvider.textColor,
              title: Constants.login,
              handleOnPressed: () =>
                  Navigator.pushNamed(context, Constants.loginRoute),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              borderColor: themeProvider.itemBackgroundColor,
              textColor: themeProvider.textColor,
              title: Constants.register,
              handleOnPressed: () =>
                  Navigator.pushNamed(context, Constants.registerRoute),
            ),
          ],
        ),
      ),
    );
  }
}
