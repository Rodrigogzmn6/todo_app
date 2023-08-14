import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/widgets/main_frame.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic> user = {
    "email": "",
    "password": "",
  };

  String errorMessage = "";
  bool showSpinner = false;

  bool checkFields() {
    if (user["email"] == null || user["email"].isEmpty) {
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
    return MainFrame(
      leadingIcon: true,
      childWidget: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: FormLayout(
          formFields: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                user["email"] = value;
              },
              style:
                  const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
              decoration: Constants.formTextFieldDecoration
                  .copyWith(hintText: Constants.emailPlaceholder),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                user["password"] = value;
              },
              style:
                  const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
              decoration: Constants.formTextFieldDecoration
                  .copyWith(hintText: Constants.passwordPlaceholder),
            ),
            const SizedBox(
              height: 32.0,
            ),
            RoundedButton(
              backgroundColor: Constants.dkItemBackgroundColor,
              title: 'Log In',
              handleOnPressed: () async {
                try {
                  setState(() {
                    showSpinner = true;
                  });
                  if (checkFields()) {
                    await _auth.signInWithEmailAndPassword(
                        email: user["email"], password: user["password"]);
                    setState(() {
                      showSpinner = false;
                    });
                    // ignore: use_build_context_synchronously
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, "/");
                  } else {
                    throw Exception(errorMessage);
                  }
                } catch (e) {
                  print(e);
                  if (e is FirebaseAuthException) {
                    errorMessage = e.message.toString();
                  }
                  showDialog(
                    context: context,
                    builder: (_) => ErrorDialog(
                      description: errorMessage,
                    ),
                    barrierDismissible: true,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
