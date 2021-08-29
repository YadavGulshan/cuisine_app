import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';

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
    debugPrint("############## I'm being executed###########");
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

      // Update the user's profile and change the state
      debugPrint(profile.toString());
      _isBusy = false;
      _isLoggedIn = true;
      name = idToken['name'];
      picture = profile['picture'];
      email = profile['email'];

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
    // Delete the refresh token from local storage
    await secureStorage.delete(key: 'refresh_token');

    // Update the state
    _isLoggedIn = false;
    _isBusy = false;

    notifyListeners();
  }

  // Initial action to be performed when the app starts

  initialAction() async {
    // Check if the refresh token exist in memory.
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');

    // If refresh token doesn't exist end the action.
    if (storedRefreshToken == null) {
      _isBusy = false;
      _isLoggedIn = false;
      notifyListeners();
    } else {
      _isBusy = false;
      _isLoggedIn = true;
      notifyListeners();
      try {
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
      }
    }
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
