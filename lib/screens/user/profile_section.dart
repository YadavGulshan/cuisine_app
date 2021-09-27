/// Manage Profile.
/// TODO: Add profile management.
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class ManageProfile extends StatelessWidget {
  ManageProfile({Key? key}) : super(key: key);

  // text editing controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    top: 16,
                  ),
                  child: Text(
                    "Profile",
                    style: GoogleFonts.lato(
                      fontSize: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 16,
                    top: 4,
                  ),
                  child: CircleAvatar(
                    child: Icon(Icons.person, size: 35),
                    radius: 40,
                  ),
                ),
                textfield("hint", "validatorString", nameController, "Name",
                    false, context, 1, 1, false),
                textfield("hint", "validatorString", phoneController, "Phone",
                    false, context, 1, 1, true),
                textfield("hint", "validatorString", addressController,
                    "Address", false, context, 3, 3, false),
                textfield("hint", "validatorString", cityController, "City",
                    false, context, 1, 1, false),
                textfield("hint", "validatorString", stateController, "State",
                    false, context, 1, 1, false),
                textfield("hint", "validatorString", zipController, "Pincode",
                    false, context, 1, 1, true),
                // Bunch of text fields

                // Save button
                Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(8)),
                        ),
                        onPressed: () {
                          SnackBar snackBar = const SnackBar(
                            content: Text("Profile Saved"),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding textfield(
    String hint,
    String validatorString,
    TextEditingController _controller,
    String label,
    bool isobsecure,
    BuildContext context,
    int minlines,
    int maxlines,
    bool isNumber,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        // left: 14,
        // right: 14,
        bottom: 16,
      ),
      child: TextFormField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        minLines: minlines,
        maxLines: maxlines,
        controller: _controller,
        style: const TextStyle(fontSize: 20),
        obscureText: isobsecure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          label: Text(label),
          alignLabelWithHint: true,
          // hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return validatorString;
        //   }
        //   return null;
        // },
      ),
    );
  }
}
