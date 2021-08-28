// import 'package:cuisine_app/screens/homepage.dart';
// import 'package:cuisine_app/screens/login_page.dart';
// import 'package:cuisine_app/services/login.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AuthStream extends StatefulWidget {
//   const AuthStream({Key? key}) : super(key: key);

//   @override
//   State<AuthStream> createState() => _AuthStreamState();
// }

// class _AuthStreamState extends State<AuthStream> {
//  @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//       stream: AuthState().user,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Homepage();
//         } else {
//           return LoginPage();
//         }
//       },
//     );
//   }
// }
