import 'dart:convert';
import 'package:cuisine_app/models/service/auth_service.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends ChangeNotifier {
  bool _isBusy = false;
  bool _isLoggedIn = false;
  String errorMessage = "";
  String name = "";
  String picture = "";
  String email = "";
  var logs = [];
  // Parse the id token from auth0
  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    // assert is used to make sure that the id token is valid
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  // Get the user's profile from auth0
  Future<Map<String, dynamic>> getProfile(String accessToken) async {
    const url = 'https://$AUTH0_DOMAIN/userinfo';
    // send a get request with bearer token.
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get User details");
    }
  }

  // Perform the login action
  Future<void> login() async {
    debugPrint("############## Login Action being executed###########");
    _isBusy = true;
    errorMessage = '';
    notifyListeners();
    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access', 'email'],
        ),
      );

      // Decode the id token
      final idToken = parseIdToken(result!.idToken.toString());

      // Send the access token and get the user's profile from auth0
      final profile = await getProfile(result.accessToken.toString());

      // Write the token to the local storage
      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);
      // debugPrint("id token: " + idToken.toString());
      debugPrint("##################################");
      final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
      debugPrint("SecureStorage: " + storedRefreshToken.toString());
      debugPrint("##################################");

      // Update the user's profile and change the state
      debugPrint(profile.toString());
      _isBusy = false;
      _isLoggedIn = true;
      name = idToken['name'];
      picture = profile['picture'];
      email = profile['email'];
      // Set the vars in device memory.
      final mem = await SharedPreferences.getInstance();
      debugPrint("##################################");
      if (mem.getString("email") == null) {
        mem.setString("email", email);
        mem.setString("name", name);
        mem.setString("picture", picture);
      } else {
        // Overwrite the existing information.

        // Name
        mem.setString("name", name);

        // Picture
        mem.setString("picture", picture);

        // Email
        mem.setString("email", email);
      }

      debugPrint(mem.getString("email"));
      debugPrint("##################################");

      // If the String in memory of key memory is null then add email.
      // mem.getString("email") ?? mem.setString("email", email);

      // Notify the listeners
      notifyListeners();
    } catch (e, s) {
      // debugPrint('login error: $e - stack: $s');
      logs.add(DateTime.now());
      logs.add("exception: $e");
      logs.add("Stack: $s");
      logs.add("=====");
      _isBusy = false;
      _isLoggedIn = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Perform the logout action
  void logoutAction() async {
    debugPrint("#################Logout Action executed##################");
    // Delete the refresh token from local storage
    await secureStorage.delete(key: 'refresh_token');

    // Access the shared preferences.
    final mem = await SharedPreferences.getInstance();

    // remove the stored content.
    mem.setString("name", "");
    mem.setString("picture", "");
    mem.setString("email", "");
    mem.setString("name", name);
    mem.setString("picture", picture);
    mem.setString("email", email);
    // Update the state
    _isLoggedIn = false;
    _isBusy = false;

    notifyListeners();
  }

  // Initial action to be performed when the app starts

  initialAction() async {
    debugPrint("############## Initial Action being executed###########");
    // Check if the refresh token exist in memory.
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    debugPrint("storedRefreshToken: " + storedRefreshToken.toString());
    // If refresh token doesn't exist end the action.
    if (storedRefreshToken == null) {
      _isBusy = false;
      _isLoggedIn = false;
      notifyListeners();
    } else {
      _isBusy = false;
      _isLoggedIn = true;
      notifyListeners();
      // Setting the profile url and other stuff.
      final mem = await SharedPreferences.getInstance();
      name = mem.getString("name").toString();
      email = mem.getString("email").toString();
      picture = mem.getString("picture").toString();
      notifyListeners();
      /*try {
        // request token, or verify the token.
        final response = await appAuth.token(
          TokenRequest(
            AUTH0_CLIENT_ID,
            AUTH0_REDIRECT_URI,
            issuer: AUTH0_ISSUER,
            refreshToken: storedRefreshToken,
          ),
        );
        final idToken = parseIdToken(response!.idToken.toString());
        // get the profile
        final profile = await getProfile(response.accessToken.toString());
        // Write the new refresh token
        secureStorage.write(key: 'refresh_token', value: response.refreshToken);

        // Change the state of app.
        _isBusy = false;
        _isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
        // Now notify the listeners.
        notifyListeners();
        return _isLoggedIn;
      } catch (e, s) {
        logs.add(DateTime.now());
        logs.add("exception: $e");
        logs.add("Stack: $s");
        logs.add("=====");
        // print('error on refresh token: $e - stack: $s');
        logoutAction();
      }*/
    }
    debugPrint("############## Initial Action Ended  ###########");
  }

  // Getters.
  bool get isbusy {
    return _isBusy;
  }

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  String get errors {
    return errorMessage;
  }

  String get username {
    return name;
  }

  String get profileUrl {
    return picture;
  }

  String get emailAddr {
    return email;
  }

  get log {
    return logs;
  }
}

/// For our custom backend.
class CustomAuth extends ChangeNotifier {
  String name = "";
  String email = "";
  int phone = 0;
  String address = "";
  String city = "";
  int pincode = 0;
  String state = "";
  bool isLoggedin = false;
  bool isbusy = false;

  Future<void> submitInfo(String name, String email, int phone, String address,
      String city, int pincode, String state) async {
    /// Storing the details in sharedPreferences
    final mem = await SharedPreferences.getInstance();
    mem.setString("name", name);
    mem.setString("email", email);
    mem.setInt("phone", phone);
    mem.setString("address", address);
    mem.setString("city", city);
    mem.setInt("pincode", pincode);
    mem.setString("state", state);
  }

  Future<void> setToken(String token) async {
    // Write the token to the local storage
    await secureStorage.write(key: 'token', value: token);
  }

  // Logout action
  Future<void> logoutAction() async {
    isLoggedin = false;
    notifyListeners();
    // Delete the token from local storage
    await secureStorage.delete(key: 'token');
    // Delete the data from shared preferences
    final mem = await SharedPreferences.getInstance();
    mem.setString("name", "");
    mem.setString("email", "");
    mem.setInt("phone", 0);
    mem.setString("address", "");
    mem.setString("city", "");
    mem.setInt("pincode", 0);
    mem.setString("state", "");
  }

  // A function that will send a post request to server with name, email and password.

  Future<User> signUprequest(String name, String email, String password,
      String confrimPassword) async {
    isbusy = true;
    notifyListeners();
    final response = await http.post(
      Uri.parse("$baseUrl/api/customer/register"),
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
    if (response.statusCode == 201) {
      isbusy = false; // Auth completed
      isLoggedin = true;
      notifyListeners();
      // Set token.
      setToken(jsonDecode(response.body)["token"]);

      return User.fromJson(jsonDecode(response.body));
    } else {
      isbusy = false;
      notifyListeners();
      throw Exception("Status Code: ${response.statusCode}");
    }
  }

  // Login action
  Future<User> loginAction(String email, String password) async {
    isbusy = true;
    notifyListeners();
    // Send a post request to the server with the username and password
    // and get the response.
    final response = await http.post(Uri.parse("$baseUrl/api/customer/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 201) {
      isbusy = false;
      isLoggedin = true;
      notifyListeners();
      return User.fromJson(jsonDecode(response.body));
    } else {
      isbusy = false;
      notifyListeners();
      throw Exception("Status code ${response.statusCode}");
    }
  }

  // Initial Action.
  initialAction() async {
    isbusy = true;
    notifyListeners();

    /// Check if token is present in device.
    var tokenVal = await secureStorage.read(key: "token");
    if (tokenVal == null) {
      isbusy == false;
      isLoggedin == false;
      notifyListeners();
    } else {
      isLoggedin = true;
      // access the shared preferences.
      final mem = await SharedPreferences.getInstance();
      // setId(mem.getString("name"));
    }
  }
}
