// ignore_for_file: prefer_final_fields

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/models/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  int currentStep = 0;
  // Text controllers here,

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  // Address section
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();

  /// Future for handling sign up action
  Future<User>? _signMeUp;
  bool _obsecure = true;
  IconData _icon = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screen.height,
            width: screen.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor)),
              child: Stepper(
                currentStep: currentStep,
                steps: getStep(),
                onStepContinue: () {
                  if (currentStep == getStep().length - 1) {
                    // Validate everything first
                    if (_signUpFormKey.currentState!.validate() &&
                        _addressFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please correct the given details')),
                      );
                    }
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (currentStep > 0) {
                    setState(() {
                      currentStep -= 1;
                    });
                  }
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
              ),
            ),
          ),
        ],
      ),
    );

    /// Future that will rout the user to homepage after the confirmation by server.
    FutureBuilder<User> buildFutureBuilder() {
      return FutureBuilder<User>(
        future: _signMeUp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      );
    }
  }

  List<Step> getStep() => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep >= 0 ? StepState.complete : StepState.indexed,
          title: const Text("Account"),
          content: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextField(
                  isobsecure: false,
                  label: "Name",
                  hint: "Your Name",
                  validatorText: "Name",
                  controller: _nameController,
                ),
                MyTextField(
                  isobsecure: false,
                  label: "Email",
                  hint: "yourEmail@example.com",
                  validatorText: "Email",
                  controller: _emailController,
                ),
                MyTextField(
                  isobsecure: false,
                  label: "Phone",
                  hint: "9876543210",
                  validatorText: "Phone",
                  controller: _phoneController,
                ),
                // Password section
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      contentPadding: const EdgeInsets.all(10),
                      enabled: true,
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _icon,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Set the obsecure to false
                          if (_obsecure) {
                            setState(() {
                              _obsecure = false;
                              _icon = Icons.remove_red_eye_outlined;
                            });
                          } else {
                            setState(() {
                              _obsecure = true;
                              _icon = Icons.remove_red_eye;
                            });
                          }
                        },
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                ),
                // Password confirmation
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obsecure,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      contentPadding: const EdgeInsets.all(10),
                      enabled: true,
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _icon,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Set the obsecure to false
                          if (_obsecure) {
                            setState(() {
                              _obsecure = false;
                              _icon = Icons.remove_red_eye_outlined;
                            });
                          } else {
                            setState(() {
                              _obsecure = true;
                              _icon = Icons.remove_red_eye;
                            });
                          }
                        },
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      // Check if the password and confirm password are same
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value != _passwordController.text) {
                        return "Password and Confirm Password must be same";
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text("Address"),
            content: Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  MyTextField(
                      label: "Address",
                      hint: "Address",
                      validatorText: "address",
                      controller: _addressController),
                  MyTextField(
                      label: "city",
                      hint: "city",
                      validatorText: "City",
                      controller: _cityController),
                  MyTextField(
                      label: "Pincode",
                      hint: "Pincode",
                      validatorText: "pincode",
                      controller: _zipCodeController),
                  MyTextField(
                      label: "State",
                      hint: "State",
                      validatorText: "State",
                      controller: _stateController),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const Text("Complete"),
            content: Column(
              children: [
                // Show the filled details here.
                // Text should have decent and style.
                CompleteSection(title: "Name: ", content: _nameController.text),
                CompleteSection(
                    title: "Email: ", content: _emailController.text),
                CompleteSection(
                    title: "Phone: ", content: _phoneController.text),
                CompleteSection(
                    title: "Address: ", content: _addressController.text),
                CompleteSection(title: "City: ", content: _cityController.text),
                CompleteSection(
                    title: "Pincode: ", content: _zipCodeController.text),
                CompleteSection(
                    title: "State: ", content: _stateController.text),
              ],
            )),
      ];
}

class CompleteSection extends StatelessWidget {
  const CompleteSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screen.width * 0.26,
            // height: screen.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: Text(
                content,
                // maxLines: 5,
                // overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ]);
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    this.isobsecure = false,
    required this.label,
    required this.hint,
    required this.validatorText,
    required this.controller,
  }) : super(key: key);
  final bool isobsecure;
  final String label;
  final String hint;
  final String validatorText;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // left: 14,
        // right: 14,
        bottom: 0,
        top: 14,
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
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
            return "Please enter a valid $validatorText";
          }
          return null;
        },
      ),
    );
  }
}
