import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/routes/home_route.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/login_route.dart';
import 'routes/register_route.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ToDoApp());
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        initialRoute: Constants.homeRoute,
        routes: {
          Constants.homeRoute: (context) => const HomeRoute(),
          Constants.loginRoute: (context) => const LoginRoute(),
          Constants.registerRoute: (context) => const RegisterRoute(),
        },
      ),
    );
  }
}
