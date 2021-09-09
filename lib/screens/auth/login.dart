import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SafeArea(
              //   child: Container(
              //     height: screen.height * 0.35,
              //     decoration: const BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage("assets/burger.jpg"),
              //             fit: BoxFit.cover)),
              //   ),
              // ),
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
                    // color: Colors.white,
                    // border: Border.all(width: 0.1)
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
                                bottom: 14, left: 14, top: 4, right: 14),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        textfield("Email", "Please enter your Email", "Email"),
                        textfield("Password", "Please enter your password",
                            "Password"),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 14,
                            ),
                            child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.red[300]),
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
                            padding: const EdgeInsets.only(bottom: 5),
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
                                height: screen.height * 0.055,
                                width: screen.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColor,
                                  // color: Color(0xFFefefef),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have a account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Padding textfield(String hint, String validatorString, String label) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          label: Text(label),
          alignLabelWithHint: true,
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
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
