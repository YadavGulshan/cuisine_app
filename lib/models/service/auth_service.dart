import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  int id;
  String name;
  String email;
  String token;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        token: json['token'],
        email: json['user']['email'],
        name: json['user']['name']);
  }

  // getters
  get userId => id;
  get userName => name;
  get userEmail => email;
  get userToken => token;

  // setters.
  void setId(int userId) {
    id = userId;
    notifyListeners();
  }

  void setName(String userName) {
    name = userName;
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }

  void setToken(String userToken) {
    token = userToken;
    notifyListeners();
  }
}
