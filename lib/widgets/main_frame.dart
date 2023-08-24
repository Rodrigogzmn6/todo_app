import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/error_dialog.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_provider.dart';

class MainFrame extends StatelessWidget {
  final Widget childWidget;
  final bool leadingIcon, logoutIcon;
  const MainFrame(
      {super.key,
      this.leadingIcon = false,
      required this.childWidget,
      this.logoutIcon = false});

  void handleVisitURL() async {
    Uri link = Uri.parse(Constants.repoLink);
    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      throw Constants.linkError;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
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
                      await userProvider.signOutUser();
                      // ignore: use_build_context_synchronously
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, Constants.homeRoute);
                    },
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Icon(
                themeProvider.theme == Constants.darkTheme
                    ? Icons.sunny
                    : Icons.mode_night_rounded,
                size: 26.0,
                color: Constants.titleTextColor,
              ),
              onTap: () {
                themeProvider.theme == Constants.darkTheme
                    ? themeProvider.theme = Constants.lightTheme
                    : themeProvider.theme = Constants.darkTheme;
              },
            ),
          ),
        ],
        automaticallyImplyLeading: leadingIcon,
        centerTitle: true,
        backgroundColor: themeProvider.backgroundColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            image: DecorationImage(
              image: themeProvider.theme == Constants.darkTheme
                  ? const AssetImage(Constants.darkBackgroundImage)
                  : const AssetImage(Constants.lightBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Constants.titleTextColor),
        title: const Text(
          "TODO",
          style: TextStyle(color: Constants.titleTextColor, fontSize: 32.0),
        ),
      ),
      backgroundColor: themeProvider.backgroundColor,
      body: childWidget,
      bottomNavigationBar: Container(
        color: themeProvider.itemBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Created by ",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: themeProvider.textColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  try {
                    handleVisitURL();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) => ErrorDialog(
                        description: e.toString(),
                      ),
                      barrierDismissible: true,
                    );
                  }
                },
                child: Text(
                  "Rodrigogzmn6",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.textColor),
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
