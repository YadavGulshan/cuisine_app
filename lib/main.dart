import 'package:cuisine_app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(color: Colors.white),
          primaryTextTheme: GoogleFonts.latoTextTheme(),
          // brightness: Brightness.dark,
        ),
        // home: const Homepage(),
        home: const LocationService());
  }
}
