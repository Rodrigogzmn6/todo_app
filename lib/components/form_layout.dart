import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {
  final List<Widget> formFields;

  const FormLayout({super.key, required this.formFields});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: formFields,
      ),
    );
  }
}
