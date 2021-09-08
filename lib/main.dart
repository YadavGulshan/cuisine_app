import 'package:cuisine_app/provider/authstream.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/auth/auth_page.dart';
import 'package:cuisine_app/screens/homepage.dart';
import 'package:cuisine_app/screens/restaurant_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/services/auth_check.dart';
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
          // Define the default brightness and colors.
          brightness: appTheme,
          primaryColor: primaryLightColor,
          iconTheme: const IconThemeData(color: primaryColor),
          primaryIconTheme: const IconThemeData(color: primaryColor),
          // accentColor: Colors.cyan[600],
          appBarTheme: (appTheme == Brightness.dark)
              ? AppBarTheme(color: Colors.grey[850])
              : const AppBarTheme(color: Colors.white),

          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        // home: Scaffold(
        //     body: RestaurantPage(
        //   title: 'Gulshan\'s Restaurant',
        //   address: 'Thane West 400607',
        //   rating: 4.5,
        //   restaurantId: 2,
        //   category: "Spicy, Sweet and mouth-Watering",
        //   imageUrl: randomImage,
        //   // imageUrl:
        //   //     "https://www.pexels.com/photo/4450334/download/?search_query=restaurant&tracking_id=zd4udgyvnsg",
        // )),
        // home: const AuthState(),
        // home: const AuthCheck(),
        home: const GetStartedPage(),
      ),
    );
  }
}
