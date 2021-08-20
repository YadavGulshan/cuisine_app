import 'package:cuisine_app/widgets/toolbar_tiles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({
    Key? key,
  }) : super(key: key);
  // double value;
  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
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
              setState(() {
                // widget.value = 0;
              });
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
}
