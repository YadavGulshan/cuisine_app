import 'package:cuisine_app/constants.dart';
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
        // theme: ThemeData(
        //   primarySwatch: Colors.purple,
        //   iconTheme: IconThemeData(
        //     color: topBarColor,
        //     // size: 24,
        //   ),
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        //   // primarySwatch: Colors.purple,
        //   // appBarTheme: const AppBarTheme(color: Colors.white),
        //   primaryTextTheme: GoogleFonts.latoTextTheme(),
        //   brightness: Brightness.dark,
        // ),
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          iconTheme: IconThemeData(color: topBarColor),
          primaryIconTheme: IconThemeData(color: topBarColor),
          // accentColor: Colors.cyan[600],

          // Define the default font family.
          // fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        // home: const Homepage(),
        home: const LocationService());
  }
}
