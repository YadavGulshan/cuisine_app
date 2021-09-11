import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:http/http.dart' as http;
// A function that will send a post request to server with name, email and password.

Future<SignUpUser> signUprequest(
    String name, String email, String password, String confrimPassword) async {
  final response = await http.post(
    Uri.parse("$baseUrl/customer/register"),
    headers: <String, String>{
      'Aaccept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confrimPassword,
    }),
  );
  if (response.statusCode == 200) {
    return SignUpUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Status Code: ${response.statusCode}");
  }
}

class SignUpUser {
  final int id;
  final String token;

  SignUpUser({required this.id, required this.token});

  factory SignUpUser.fromJson(Map<String, dynamic> json) {
    return SignUpUser(id: json['user']['id'], token: json['token']);
  }
}
