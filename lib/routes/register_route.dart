import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/custom_form_field.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/theme_provider.dart';

class RegisterRoute extends StatefulWidget {
  const RegisterRoute({Key? key}) : super(key: key);

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  String errorMessage = "";
  bool showSpinner = false;
  Map<String, dynamic> user = {
    "name": "",
    "lastname": "",
    "email": "",
    "password": "",
    "task": []
  };

  bool checkFields() {
    if (user["name"] == null || user["name"].isEmpty) {
      errorMessage = Constants.blankName;
      return false;
    } else if (user["lastname"] == null || user["lastname"].isEmpty) {
      errorMessage = Constants.blankLastName;
      return false;
    } else if (user["email"] == null || user["email"].isEmpty) {
      errorMessage = Constants.blankEmail;
      return false;
    } else if (user["password"] == null || user["password"].isEmpty) {
      errorMessage = Constants.blankPassword;
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    void handleOnRegister() async {
      setState(() {
        showSpinner = true;
      });
      try {
        if (checkFields()) {
          await userProvider.registerUser(
            user["name"],
            user["lastname"],
            user["email"],
            user["password"],
          );
          // ignore: use_build_context_synchronously
          if (!context.mounted) return;
          Navigator.pushNamed(context, "/");
        } else {
          throw (errorMessage);
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => ErrorDialog(
            description: e is FirebaseAuthException
                ? e.message.toString()
                : e.toString(),
          ),
          barrierDismissible: true,
        );
      } finally {
        setState(() {
          showSpinner = false;
        });
      }
    }

    return MainFrame(
      leadingIcon: true,
      childWidget: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: FormLayout(
            formFields: [
              CustomFormField(
                placeholder: Constants.namePlaceholder,
                handleOnChange: (value) {
                  user['name'] = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomFormField(
                placeholder: Constants.lastnamePlaceholder,
                handleOnChange: (value) {
                  user['lastname'] = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomFormField(
                keyboardType: TextInputType.emailAddress,
                placeholder: Constants.emailPlaceholder,
                handleOnChange: (value) {
                  user['email'] = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomFormField(
                obscureText: true,
                placeholder: Constants.passwordPlaceholder,
                handleOnChange: (value) {
                  user['password'] = value;
                },
              ),
              const SizedBox(
                height: 32.0,
              ),
              RoundedButton(
                backgroundColor: Constants.activeTextColor,
                textColor: themeProvider.textColor,
                borderColor: themeProvider.itemBackgroundColor,
                title: Constants.register,
                handleOnPressed: handleOnRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
