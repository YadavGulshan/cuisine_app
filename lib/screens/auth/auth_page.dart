// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/auth/login.dart';
import 'package:flutter/material.dart';

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
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        // color: primaryColor,
        child: SafeArea(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screen.height,
                // color: Colors.black,
                child: Image.asset(
                  "assets/login_bg.png",
                  // "assets/get_started_page.gif",
                  fit: BoxFit.cover,
                ),
              ),
              // Lottie.asset("assets/GetStartedPage_animation.json"),
              Positioned(
                bottom: 10,
                left: 20,
                child: Container(
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
                            style: Theme.of(context).textTheme.headline1,
                            children: const [
                              TextSpan(
                                  text: appName,
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.green,
                                  ))
                            ]),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: button(context, screen, "Get Started")),
                    ],
                  ),
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

Widget button(context, Size screen, String title) {
  return Container(
    height: screen.height * 0.065,
    width: screen.width * 0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).primaryColor,
    ),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19,
        ),
      ),
    ),
  );
}
