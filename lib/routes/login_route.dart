import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:todo_app/components/custom_form_field.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MainFrame(
      leadingIcon: true,
      childWidget: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: FormLayout(
            formFields: [
              CustomFormField(
                keyboardType: TextInputType.emailAddress,
                placeholder: Constants.emailPlaceholder,
                handleOnChange: (value) {
                  user["email"] = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomFormField(
                obscureText: true,
                placeholder: Constants.passwordPlaceholder,
                handleOnChange: (value) {
                  user["password"] = value;
                },
              ),
              const SizedBox(
                height: 32.0,
              ),
              RoundedButton(
                backgroundColor: themeProvider.backgroundColor,
                textColor: themeProvider.textColor,
                borderColor: themeProvider.itemBackgroundColor,
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
      ),
    );
  }
}

// class FormField extends StatelessWidget {
//   const FormField({
//     super.key,
//     required this.user,
//     required this.themeProvider,
//   });

//   final Map<String, dynamic> user;
//   final ThemeProvider themeProvider;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       keyboardType: TextInputType.emailAddress,
//       textAlign: TextAlign.center,
//       onChanged: (value) {
//         user["email"] = value;
//       },
//       style: TextStyle(
//         color: themeProvider.textColor,
//         fontSize: 20.0,
//       ),
//       decoration: Constants.formTextFieldDecoration.copyWith(
//         hintText: Constants.emailPlaceholder,
//         hintStyle: TextStyle(
//           color: themeProvider.checkedTextColor,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: themeProvider.itemBackgroundColor, width: 1.0),
//           borderRadius: const BorderRadius.all(Radius.circular(32.0)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: themeProvider.itemBackgroundColor, width: 2.0),
//           borderRadius: const BorderRadius.all(Radius.circular(32.0)),
//         ),
//       ),
//     );
//   }
// }
