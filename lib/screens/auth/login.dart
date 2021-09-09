import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: screen.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Container(
                  height: screen.height * 0.45,
                  margin: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 4, left: 14, top: 4, right: 14),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                          ),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 20),
                            obscureText: false,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              enabled: true,
                              label: Text("Email"),
                              alignLabelWithHint: true,
                              hintText: "Email",
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.0),
                              ),
                            ),
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                          ),
                        ),
                        textfield("Password", "Please enter your password",
                            "Password", true),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                right: 14,
                              ),
                              child: InkWell(
                                  onTap: () {},
                                  child: const Text("Forget password?"))),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: Container(
                              height: screen.height * 0.065,
                              width: screen.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have a account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            InkWell(
                                onTap: () {},
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: primaryColor),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Padding textfield(
      String hint, String validatorString, String label, bool isobsecure) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        obscureText: isobsecure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          label: Text(label),
          alignLabelWithHint: true,
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorString;
          }
          return null;
        },
      ),
    );
  }
}
