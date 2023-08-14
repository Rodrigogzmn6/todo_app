import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class MainFrame extends StatelessWidget {
  final Widget childWidget;
  final bool leadingIcon, logoutIcon;
  MainFrame(
      {super.key,
      this.leadingIcon = false,
      required this.childWidget,
      this.logoutIcon = false});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: leadingIcon,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg-mobile-dark.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Constants.titleTextColor),
        title: const Text(
          "TODO",
          style: TextStyle(color: Constants.titleTextColor, fontSize: 32.0),
        ),
        centerTitle: true,
        actions: [
          logoutIcon
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.logout_rounded,
                      size: 26.0,
                      color: Constants.titleTextColor,
                    ),
                    onTap: () async {
                      await _auth.signOut();
                      // ignore: use_build_context_synchronously
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: const Icon(
                Icons.sunny,
                size: 26.0,
                color: Constants.titleTextColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Constants.dkBackgroundColor,
      body: Center(
        child: childWidget,
      ),
      //resizeToAvoidBottomInset: false,
    );
  }
}
