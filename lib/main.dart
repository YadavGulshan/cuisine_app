import 'package:cuisine_app/provider/authstream.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/auth/auth_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/user.dart';
import 'package:flutter/material.dart';
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
        ),
        ChangeNotifierProvider.value(
          value: User(),
        ),
        ChangeNotifierProvider.value(
          value: AuthState(),
        ),
        ChangeNotifierProvider.value(
          value: CartModel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: appTheme,
          primaryColor: primaryLightColor,
          iconTheme: const IconThemeData(color: primaryColor),
          primaryIconTheme: const IconThemeData(color: primaryColor),
          appBarTheme: (appTheme == Brightness.dark)
              ? AppBarTheme(color: Colors.grey[850])
              : const AppBarTheme(color: Colors.white),
          fontFamily: 'ribik',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.normal),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'rubik'),
          ),
        ),
        home: const GetStartedPage(),
      ),
    );
  }
}
