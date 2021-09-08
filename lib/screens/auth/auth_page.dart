// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class GetStartedPage extends StatelessWidget {
  final loginCallback;
  // final String loginError;
  const GetStartedPage({
    this.loginCallback,
    Key? key,
    // required this.loginError,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screen.height * 0.5,
                // color: Colors.black,
                child: Image.asset(
                  "assets/get_started_page.gif",
                  fit: BoxFit.cover,
                ),
              ),
              // Lottie.asset("assets/GetStartedPage_animation.json"),
              Container(
                height: screen.height * 0.27,
                width: screen.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Welcome to\n",
                          style: GoogleFonts.bubblegumSans(
                            fontSize: 38,
                          ),
                          children: [
                            TextSpan(
                                text: appName,
                                style: GoogleFonts.lato(
                                  fontSize: 42,
                                  color: Colors.lightGreenAccent,
                                ))
                          ]),
                    ),
                    InkWell(
                        onTap: () {
                          pushNewScreen(context, screen: LoginPage());
                        },
                        child: button(screen, "Get Started")),
                  ],
                ),
              )
            ],
          ),
        ),
        // Lottie.asset("assets/GetStartedPage_animation.json", fit: BoxFit.fill),
      ),
    );
  }
}

Widget button(Size screen, String title) {
  return Container(
    height: screen.height * 0.065,
    width: screen.width * 0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue[300],
    ),
    child: Center(
      child: Text(
        title,
        style: GoogleFonts.bubblegumSans(
          color: Colors.white,
          fontSize: 19,
        ),
      ),
    ),
  );
}
