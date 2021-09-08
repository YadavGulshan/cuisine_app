import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screen.height,
        color: primaryColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screen.height * 0.45,
                child: SafeArea(
                  child: Image.asset(
                    "assets/login.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: screen.height * 0.35,
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 14, left: 14, top: 4, right: 14),
                        child: Text(
                          "Login",
                          style: GoogleFonts.bubblegumSans(fontSize: 42),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                          bottom: 20,
                        ),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your email!';
                          //   }
                          //   return null;
                          // },
                          // enabled: true,
                          // autofocus: autofocus,
                          // cursorHeight: 25,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            enabled: true,
                            label: Text("Email"),
                            // border: InputBorder.none,
                            alignLabelWithHint: true,
                            hintText: "Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                        ),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your password';
                          //   }
                          //   return null;
                          // },
                          style: const TextStyle(fontSize: 20),
                          obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),

                            enabled: true,
                            label: Text("Password"),

                            // border: InputBorder.none,
                            alignLabelWithHint: true,
                            hintText: "Password",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                          ),
                          child: TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red[300]),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Forget password?")),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: InkWell(
                            onTap: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: Container(
                              height: screen.height * 0.055,
                              width: screen.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "login",
                                  style: GoogleFonts.bubblegumSans(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screen.height * 0.09,
                  left: 20,
                  right: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a account?",
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.lato(color: primaryLightColor),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
