import 'package:cuisine_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/toolbar_tiles.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    required this.longitude,
    required this.latitude,
    required this.address,
  }) : super(key: key);

  final String longitude;
  final String latitude;
  final String address;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: MyCustomDrawer(
        value: 0,
      ),
      // body: ,
    );
  }
}
