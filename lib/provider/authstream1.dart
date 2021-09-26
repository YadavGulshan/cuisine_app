import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

signInUser(
  String email,
  String password,
  BuildContext context,
) async {
  final http.Response response = await http.post(
    // https://56dff1578390.up.railway.app/api/customer/login
    // Uri.parse("$baseUrl/api/customer/login"),
    Uri.parse("$baseUrl/api/customer/login"),
    headers: {
      "Accept": 'application/json',
      "User-Agent": 'Flutter 2.6',
    },
    body: {
      "email": email,
      "password": password,
    },
  );

  if (response.statusCode == 201) {
    // This means authentication is successfull.
    // Parse the json response
    var _service = AuthService.fromJson(jsonDecode(response.body));

    /// Save the token in the secure storage
    const storage = FlutterSecureStorage();
    await storage.write(key: "token", value: _service.token);

    // Write other details to pref storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _service.name);
    prefs.setString('email', _service.email);
    // push to next screen. i.e home page.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Invalid email or password"),
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

/// Sign UP user
signUpUser(
  String name,
  String email,
  String password,
  BuildContext context,
) async {
  debugPrint("Signing up user");
  debugPrint("$name, $email, $password");
  final http.Response response = await http.post(
    // https://56dff1578390.up.railway.app/api/customer/login
    // Uri.parse("$baseUrl/api/customer/login"),
    Uri.parse("$baseUrl/api/customer/register"),
    headers: {
      "Accept": 'application/json',
      "User-Agent": 'Flutter 2.6',
    },
    body: {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": password,
    },
  );

  if (response.statusCode == 201) {
    // This means authentication is successfull.
    // Parse the json response
    var _service = AuthService.fromJson(jsonDecode(response.body));

    /// Save the token in the secure storage
    const storage = FlutterSecureStorage();
    await storage.write(key: "token", value: _service.token);

    // Write other details to pref storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _service.name);
    prefs.setString('email', _service.email);

    /// Now set the provider [AuthService]
    /// This will be used in the entire app
    /// to check if the user is logged in or not
    /// and also to get the user details

    Provider.of<AuthService>(context).setId(_service.id);
    Provider.of<AuthService>(context).setName(_service.name);
    Provider.of<AuthService>(context).setEmail(_service.email);
    Provider.of<AuthService>(context).setToken(_service.token);
    Provider.of<AuthService>(context).setIsLoggedIn(true);
  } else {
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

/// 1. Post request to server.
/// 2. Get response from server.
/// 3. Parse response.
/// 4. Return parsed response.

class AuthService extends ChangeNotifier {
  bool isLoggedIn = false;
  // User section
  int id = 0;
  String name = "";
  String email = "";
  String token = "";

  AuthService({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory AuthService.fromJson(Map<String, dynamic> json) {
    return AuthService(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
      // Other stuff are not working right now.
      // TODO: Persist this information to disk
    );
  }

  initialAction(BuildContext context) {
    // Check the memory if token is stored or not.
    const storage = FlutterSecureStorage();

    String token = storage.read(key: 'token').toString();

    if (token != "") {
      // If token is stored in memory, then set the token and set the isLoggedIn to true.
      isLoggedIn = true;
      notifyListeners();
    }
  }

  // Some setters.
  setIsLoggedIn(bool value) {
    isLoggedIn = value;
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
  get loginCheck => isLoggedIn;
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