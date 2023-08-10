import 'package:flutter/material.dart';
import 'package:todo_app/components/form_layout.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/components/rounded_button.dart';
import 'package:todo_app/widgets/main_frame.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      childWidget: FormLayout(
        formFields: [
          TextField(
            keyboardType: TextInputType.name,
            textAlign: TextAlign.center,
            // onChanged: (value) {
            //   email = value;
            // },
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
            // onChanged: (value) {
            //   email = value;
            // },
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
            // onChanged: (value) {
            //   email = value;
            // },
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
            //   onChanged: (value) {
            //     password = value;
            //   },
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
            handleOnPressed: () => {print('hola')},
          )
        ],
      ),
    );
  }
}
