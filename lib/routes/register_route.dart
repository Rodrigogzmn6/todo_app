import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return MainFrame(
      leadingIcon: true,
      childWidget: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: FormLayout(
          formFields: [
            TextField(
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onChanged: (value) {
                user['name'] = value;
              },
              style:
                  const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
              decoration: Constants.formTextFieldDecoration
                  .copyWith(hintText: Constants.namePlaceholder),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onChanged: (value) {
                user['lastname'] = value;
              },
              style:
                  const TextStyle(color: Constants.dkTextColor, fontSize: 20.0),
              decoration: Constants.formTextFieldDecoration
                  .copyWith(hintText: Constants.lastnamePlaceholder),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                user['email'] = value;
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
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                user['password'] = value;
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
    );
  }
}
