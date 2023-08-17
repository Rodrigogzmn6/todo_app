import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MainFrame extends StatelessWidget {
  final Widget childWidget;
  final bool leadingIcon, logoutIcon;
  MainFrame(
      {super.key,
      this.leadingIcon = false,
      required this.childWidget,
      this.logoutIcon = false});

  final _auth = FirebaseAuth.instance;

  void handleVisitURL() async {
    Uri link = Uri.parse(Constants.repoLink);
    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      throw "Couldn't open link";
    }
  }

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
      body: childWidget,
      bottomNavigationBar: Container(
        color: Constants.dkItemBackgroundColor,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Created by ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Constants.dkTextColor),
                ),
              ),
              GestureDetector(
                onTap: handleVisitURL,
                child: Text(
                  "Rodrigogzmn6",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.dkTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
