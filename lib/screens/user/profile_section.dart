/// Manage Profile.
/// TODO: Add profile management.
import 'package:cuisine_app/screens/user/bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageProfile extends StatefulWidget {
  ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController zipController = TextEditingController();
  late String name = "";
  late String phone = "";
  late String address = "";
  late String city = "";
  late String state = "";
  late String zip = "";
  late String email = "";
  void GetUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name").toString();
    email = prefs.getString("email").toString();
    phone = prefs.getString("phone").toString();
    address = prefs.getString("address").toString();
    city = prefs.getString("city").toString();
    state = prefs.getString("state").toString();
    zip = prefs.getString("pincode").toString();
    debugPrint("Action completed");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserDetails();
  }

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
                    bottom: 0,
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
                Divider(
                  thickness: 2,
                  endIndent: 50,
                  color: Theme.of(context).primaryColorLight,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: CircleAvatar(
                //     child: Icon(Icons.person, size: 35),
                //     radius: 40,
                //   ),
                // ),
                Details(title: "Name", value: name),
                Details(title: "Email", value: email),
                Details(title: "Phone", value: phone),
                Details(title: "Address", value: address),
                Details(title: "City", value: city),
                Details(title: "State", value: state),
                Details(title: "Zip", value: zip),
                // Save button
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(
                        //   Theme.of(context).primaryColor,
                        // ),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(8)),
                      ),
                      onPressed: () {
                        // SnackBar snackBar = const SnackBar(
                        //   content: Text("Profile Saved"),
                        //   duration: Duration(seconds: 1),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text(
                        "Edit Details",
                        style: TextStyle(
                          fontSize: 16,
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
          enabledBorder: const OutlineInputBorder(),
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

class Details extends StatelessWidget {
  final String title;
  final String value;
  const Details({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                title + ": ",
                textAlign: TextAlign.start,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            // height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.grey[550],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
