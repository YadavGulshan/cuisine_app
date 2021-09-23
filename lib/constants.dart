import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// const Color topBarColor = Color(0xFF6002ee);
const Color primaryColor = Color(0xFF2563EB);
const Color primaryLightColor = Color(0xFFEFF6FF);
Brightness appTheme = Brightness.light;
const String appName = "Food Delivery App";
String testUrl =
    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640";

// Auth0 part
final FlutterAppAuth appAuth = FlutterAppAuth();
// For storing the token
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

// Auth0 variables
const AUTH0_DOMAIN = 'bufferoverflow.eu.auth0.com';
const AUTH0_CLIENT_ID = 'WjeGvua61kk0jmYdql3FGFh3PJLdgNwG';

const AUTH0_REDIRECT_URI = 'com.auth0.cuisine://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';


