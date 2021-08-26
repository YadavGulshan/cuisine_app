import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/homepage.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CurrentLocation(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
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
            brightness: appTheme,
            primaryColor: primaryLightColor,
            iconTheme: const IconThemeData(color: primaryColor),
            primaryIconTheme: const IconThemeData(color: primaryColor),
            // accentColor: Colors.cyan[600],
            appBarTheme: (appTheme == Brightness.dark)
                ? AppBarTheme(color: Colors.grey[850])
                : const AppBarTheme(color: Colors.white),

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
          home: Homepage()),
    );
  }
}
