// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  var loginCallback;
  // final String loginError;
  LoginPage({
    required this.loginCallback,
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
              Lottie.asset("assets/loginpage_animation.json"),
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
                    Text(
                      appName,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.eczar(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          loginCallback();
                        },
                        child: button(screen, "LOGIN")),
                    button(screen, "SIGN UP"),
                  ],
                ),
              )
            ],
          ),
        ),
        // Lottie.asset("assets/loginpage_animation.json", fit: BoxFit.fill),
      ),
    );
  }
}

Widget button(Size screen, String title) {
  return Container(
    height: screen.height * 0.065,
    width: screen.width * 0.3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
    ),
    child: Center(
      child: Text(
        title,
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 19,
        ),
      ),
    ),
  );
}
