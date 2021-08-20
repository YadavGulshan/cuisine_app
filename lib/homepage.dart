import 'package:cuisine_app/screens/custom_drawer.dart';
import 'package:cuisine_app/widgets/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // double value = 0;
    return Scaffold(
        body: GestureDetector(
      onPanUpdate: (details) {
        // Swiping in left direction.
        if (details.delta.dx < 0) {
          pushNewScreen(context, screen: const MyCustomDrawer());
        }
      },
      child: MainPage(
        address: widget.address,
      ),
    )
        // body: ,
        );
  }
}

Widget myDrawer(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  // double screenWidth = MediaQuery.of(context).size.width;
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
