import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// signInmeUser(
//   String email,
//   String password,
//   BuildContext context,
// ) async {
//   final http.Response response = await http.post(
//     // https://56dff1578390.up.railway.app/api/customer/login
//     // Uri.parse("$baseUrl/api/customer/login"),
//     Uri.parse("$baseUrl/api/customer/login"),
//     headers: {
//       "Accept": 'application/json',
//       "User-Agent": 'Flutter 2.6',
//     },
//     body: {
//       "email": email,
//       "password": password,
//     },
//   );

//   if (response.statusCode == 201) {
//     // This means authentication is successfull.
//     // Parse the json response
//     var _service = AuthService.fromJson(jsonDecode(response.body));

//     /// Save the token in the secure storage
//     const storage = FlutterSecureStorage();
//     await storage.write(key: "token", value: _service.token);

//     // Write other details to pref storage
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', _service.name);
//     prefs.setString('email', _service.email);
//     // push to next screen. i.e home page.
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const MainPage(),
//       ),
//     );
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: const Text("Invalid email or password"),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// /// Sign UP user
// signmeUpUser(
//   String name,
//   String email,
//   String password,
//   BuildContext context,
// ) async {
//   debugPrint("Signing up user");
//   debugPrint("$name, $email, $password");
//   final http.Response response = await http.post(
//     // https://56dff1578390.up.railway.app/api/customer/login
//     // Uri.parse("$baseUrl/api/customer/login"),
//     Uri.parse("$baseUrl/api/customer/register"),
//     headers: {
//       "Accept": 'application/json',
//       "User-Agent": 'Flutter 2.6',
//     },
//     body: {
//       "name": name,
//       "email": email,
//       "password": password,
//       "password_confirmation": password,
//     },
//   );

//   if (response.statusCode == 201) {
//     debugPrint("Done!!");
//     // This means authentication is successfull.
//     // Parse the json response
//     var _service = AuthService.fromJson(jsonDecode(response.body));

//     /// Save the token in the secure storage
//     const storage = FlutterSecureStorage();
//     await storage.write(key: "token", value: _service.token);

//     // Write other details to pref storage
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', _service.name);
//     prefs.setString('email', _service.email);

//     /// Now set the provider [AuthService]
//     /// This will be used in the entire app
//     /// to check if the user is logged in or not
//     /// and also to get the user details

//     // Provider.of<AuthService>(context, listen: false).setId(_service.id);
//     // Provider.of<AuthService>(context, listen: false).setName(_service.name);
//     // Provider.of<AuthService>(context, listen: false).setEmail(_service.email);
//     // Provider.of<AuthService>(context, listen: false).setToken(_service.token);
//     // Provider.of<AuthService>(context, listen: false).setIsLoggedIn(true);

//     /// TODO: implement statemanagement.
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const MainPage(),
//       ),
//     );
//   } else {
//     debugPrint(response.body);
//     debugPrint(response.statusCode.toString());
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: const Text("Something Gone Wrong, Please try again."),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

/// 1. Post request to server.
/// 2. Get response from server.
/// 3. Parse response.
/// 4. Return parsed response.

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isbusy = false;
  // User section
  int id = 0;
  String name = "";
  String email = "";
  String token = "";

  // AuthService({
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.token,
  // });

  // factory AuthService.fromJson(Map<String, dynamic> json) {
  //   return AuthService(
  //     id: json['user']['id'],
  //     name: json['user']['name'],
  //     email: json['user']['email'],
  //     token: json['token'],
  //     // Other stuff are not working right now.
  //     // TODO: Persist this information to disk
  //   );
  // }

  //  Parse the id token
  parseAndProcessInfo(Map<String, dynamic> json) async {
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    token = json['token'];
    notifyListeners();

    debugPrint("Adding info to storage");

    /// Now add this data into pref storage.
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", id);
    prefs.setString("name", name);
    prefs.setString("email", email);

    /// Store the token in secure storage.
    const storage = FlutterSecureStorage();
    await storage.write(key: "token", value: token);

    debugPrint("Task of storing info ended.");
  }

  signUp(
    String _name,
    String _email,
    String _password,
    BuildContext context,
    String phone,
    String address,
    String city,
    String pincode,
    String state,
  ) async {
    _isbusy = true;
    notifyListeners();

    debugPrint("Signing up user");
    debugPrint("$_name, $_email, $_password");
    final http.Response response = await http.post(
      // https://56dff1578390.up.railway.app/api/customer/login
      // Uri.parse("$baseUrl/api/customer/login"),
      Uri.parse("$baseUrl/api/customer/register"),
      headers: {
        "Accept": 'application/json',
        "User-Agent": 'Flutter 2.6',
      },
      body: {
        "name": _name,
        "email": _email,
        "password": _password,
        "password_confirmation":
            _password, // Since UI is handling the validation.
      },
    );

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
      debugPrint("Done!!");

      /// Sign Up approved
      _isLoggedIn = true;
      _isbusy = false;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("phone", phone);
      prefs.setString("address", address);
      prefs.setString("city", city);
      prefs.setString("pincode", pincode);
      prefs.setString("state", state);

      debugPrint("Done!!");

      parseAndProcessInfo(jsonDecode(response.body));
    } else {
      _isbusy = false;
      notifyListeners();
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Something Gone Wrong, Please try again."),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  signIn(String _email, String _password, BuildContext context) async {
    _isbusy = true;
    notifyListeners();
    final http.Response response = await http.post(
      // https://56dff1578390.up.railway.app/api/customer/login
      // Uri.parse("$baseUrl/api/customer/login"),
      Uri.parse("$baseUrl/api/customer/login"),
      headers: {
        "Accept": 'application/json',
        "User-Agent": 'Flutter 2.6',
      },
      body: {
        "email": _email,
        "password": _password,
      },
    );

    if (response.statusCode == 201) {
      /// Means auth is sucess.
      parseAndProcessInfo(jsonDecode(response.body));

      // Set the is logged in to true.

      _isLoggedIn = true;
      _isbusy = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      _isLoggedIn = false;
      _isbusy = false;
      notifyListeners();
      const snackBar = SnackBar(content: Text('Invalid Email or Password!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("email");
    prefs.remove("name");
    prefs.remove("id");

    // delete the token.
    const storage = FlutterSecureStorage();
    await storage.write(
        key: "token", value: ""); // overwrite the value with null

    _isLoggedIn = false;
    notifyListeners();
    debugPrint("Logout Action ended");
  }

  initialAction(BuildContext context) async {
    debugPrint("Initial Action##################################");
    _isbusy = true;
    notifyListeners();
    // Check the memory if token is stored or not.
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');
    debugPrint("Token: $token");
    if (token != null && token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      name = prefs.getString("name").toString();
      email = prefs.getString("email").toString();
      id = prefs.getInt("id")!.toInt();
      _isbusy = false;
      // If token is stored in memory, then set the token and set the isLoggedIn to true.
      _isLoggedIn = true;
      notifyListeners();
    } else {
      _isbusy = false;
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  // Some setters.
  setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  setName(String value) {
    name = value;
    notifyListeners();
  }

  setEmail(String value) {
    email = value;
    notifyListeners();
  }

  setToken(String value) {
    token = value;
    notifyListeners();
  }

  setId(int value) {
    id = value;
    notifyListeners();
  }

  // Some getters.
  get loginCheck => _isLoggedIn;
  get busycheck => _isbusy;
  get userName => name;
  get userEmail => email;
  get userToken => token;
  get userId => id;
}

// Sign up
// {
//   "user": {
//     "name": "Gulshan yadav",
//     "email": "test1@test1.com",
//     "updated_at": "2021-09-26T07:12:30.000000Z",
//     "created_at": "2021-09-26T07:12:30.000000Z",
//     "id": 8
//   },
//   "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiR3Vsc2hhbiB5YWRhdiIsImVtYWlsIjoidGVzdDFAdGVzdDEuY29tIiwidXBkYXRlZF9hdCI6IjIwMjEtMDktMjZUMDc6MTI6MzAuMDAwMDAwWiIsImNyZWF0ZWRfYXQiOiIyMDIxLTA5LTI2VDA3OjEyOjMwLjAwMDAwMFoiLCJpZCI6OH0.8RC8MOUUrapcomu1iHaVlmD2kpUFb3DgwfxaCntfc2s"
// }

// Login
// {
//   "user": {
//     "id": 7,
//     "name": "Gulshan yadav",
//     "address": null,
//     "latitude": null,
//     "longitude": null,
//     "phone": null,
//     "email": "test@test1.com",
//     "created_at": "2021-09-25T16:48:39.000000Z",
//     "updated_at": "2021-09-25T16:48:39.000000Z"
//   },
//   "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NywibmFtZSI6Ikd1bHNoYW4geWFkYXYiLCJhZGRyZXNzIjpudWxsLCJsYXRpdHVkZSI6bnVsbCwibG9uZ2l0dWRlIjpudWxsLCJwaG9uZSI6bnVsbCwiZW1haWwiOiJ0ZXN0QHRlc3QxLmNvbSIsImNyZWF0ZWRfYXQiOiIyMDIxLTA5LTI1VDE2OjQ4OjM5LjAwMDAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMS0wOS0yNVQxNjo0ODozOS4wMDAwMDBaIn0.YKVZzvtcC285pKo3o5sXZGgKMyLN74RfvS3Rlofwimc"
// }