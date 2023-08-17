import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/custom_form_field.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/theme_provider.dart';

class RegisterRoute extends StatefulWidget {
  const RegisterRoute({Key? key}) : super(key: key);

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
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
                backgroundColor: themeProvider.backgroundColor,
                textColor: themeProvider.textColor,
                borderColor: themeProvider.itemBackgroundColor,
                title: 'Register',
                handleOnPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (checkFields()) {
                      await _auth.createUserWithEmailAndPassword(
                          email: user["email"], password: user["password"]);
                      _firestore.collection("users").add({
                        "name": user["name"].trim(),
                        "lastname": user["lastname"].trim(),
                        "email": user["email"].trim(),
                        "tasks": Constants.dummyTasks,
                      });
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
