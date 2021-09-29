import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/authstream1.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/provider/infoprovider.dart';
import 'package:cuisine_app/screens/auth/auth_page.dart';
import 'package:cuisine_app/screens/homepage.dart';
import 'package:cuisine_app/screens/order/checkout_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // ChangeNotifierProvider.value(
        //   value: User(),
        // ),
        // ChangeNotifierProvider.value(
        //   value: AuthState(),
        // ),
        ChangeNotifierProvider.value(
          value: CartModel(),
        ),
        ChangeNotifierProvider.value(
          value: Info(),
        ),
        ChangeNotifierProvider.value(
          value: AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          primaryColorLight: primaryLightColor,
          iconTheme: const IconThemeData(color: primaryColor),
          primaryIconTheme: const IconThemeData(color: primaryColor),
          appBarTheme: (Theme.of(context).brightness == Brightness.dark)
              ? AppBarTheme(color: Colors.grey[850])
              : const AppBarTheme(color: Colors.white),
          fontFamily: 'ribik',
          textTheme: TextTheme(
              headline1: GoogleFonts.inter(
                fontSize: 48.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              headline4: GoogleFonts.lato(
                fontSize: 36.0,
              ),
              headline6: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyText2: GoogleFonts.rubik(
                fontSize: 16.0,
              ),
              button: GoogleFonts.rubik(fontSize: 16.0, color: Colors.white)),
        ),
        home: const InitialCheck(),
        // home: const CheckoutPage(),
        // home: CheckoutScreen(),
      ),
    );
  }
}

class InitialCheck extends StatefulWidget {
  const InitialCheck({Key? key}) : super(key: key);

  @override
  InitialCheckState createState() => InitialCheckState();
}

class InitialCheckState extends State<InitialCheck> {
  void initialAction() {
    Provider.of<AuthService>(context, listen: false).initialAction(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initialAction();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService provider = Provider.of<AuthService>(context, listen: true);
    return (provider.busycheck)
        ? const Center(child: CircularProgressIndicator())
        : (provider.loginCheck)
            ? const MainPage()
            : const GetStartedPage();
    // return ManageProfile();
  }
}
