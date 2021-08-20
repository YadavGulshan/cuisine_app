import 'dart:math';

import 'package:cuisine_app/widgets/custom_drawer.dart';
import 'package:cuisine_app/widgets/mainpage.dart';
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
    double value = 0;
    return Scaffold(
      body: Stack(
        children: [
          MyCustomDrawer(value: value),
          Transformer(
            value: value,
            address: widget.address,
          ),
        ],
      ),
      // body: ,
    );
  }
}

class Transformer extends StatefulWidget {
  Transformer({Key? key, required this.value, required this.address})
      : super(key: key);
  double value = 0;
  String address;
  @override
  _TransformerState createState() => _TransformerState();
}

class _TransformerState extends State<Transformer> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: widget.value),
        duration: const Duration(microseconds: 500),
        builder: (_, double val, __) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 3, 250 * val)
              ..rotateY((pi / 6) * val),
            child: Scaffold(
              body: MainPage(
                value: widget.value,
                address: widget.address,
              ),
              drawer: myDrawer(context),
            ),
          );
        });
  }
}

Widget myDrawer(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Container(
    color: const Color(0xFF27282C),
    child: Column(
      children: [
        Container(
          height: screenHeight / 5,
          color: const Color(0xFF1D1E20),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                ),
                Center(
                  child: Text(
                    "Gulshan Yadav",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFB2B1B6),
                      size: 32,
                    ))
              ],
            ),
          ),
        ),
        ToolBarTile(
          icon: Icons.home,
          title: "Home",
          ontap: () {
            // setState(() {
            //   widget.value = 0;
            // });
          },
        ),
        ToolBarTile(
            icon: Icons.card_travel, title: "Your Orders", ontap: () {}),
        ToolBarTile(
          icon: Icons.book,
          title: "Address Book",
          ontap: () {},
        ),
        ToolBarTile(
          icon: Icons.info,
          title: "About",
          ontap: () {},
        ),
        ToolBarTile(
          icon: Icons.logout,
          title: "Log out",
          ontap: () {},
        ),
        const Spacer(
          flex: 10,
        ),
      ],
    ),
  );
}
