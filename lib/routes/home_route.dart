import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/widgets/main_frame.dart';
import 'package:todo_app/widgets/new_task.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async {
    try {
      if (_auth.currentUser == null) {
        Navigator.pushNamed(context, "/");
      }
      loggedInUser = _auth.currentUser!;
      print(loggedInUser);
    } catch (e) {
      String errorMessage = "";
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
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      logoutIcon: true,
      childWidget: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: NewTask(),
      ),
    );
  }
}
