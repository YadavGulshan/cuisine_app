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
      body: MainPage(
        address: widget.address,
      ),
      drawer: Drawer(
        child: Container(
          // color: Colors.white,
          // color: const Color(0xFF27282C),
          child: Column(
            children: [
              Container(
                color: const Color(0xFF232830),
                height: MediaQuery.of(context).size.height / 5,
                // color: const Color(0xFF1D1E20),
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
                        child: Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width / 2,
                          // color: Colors.black,
                          child: Text(
                            "Gulshan Yadav",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              // color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TitleWidget(
                title: "FOOD AND GROCERIES ORDERS",
                padding: const EdgeInsets.fromLTRB(25, 14, 14, 0),
                fontSize: 14,
              ),
              ToolBarTile(
                  icon: Icons.card_travel, title: "Your Orders", ontap: () {}),
              ToolBarTile(
                  icon: Icons.favorite_border_outlined,
                  title: "Favourite Orders",
                  ontap: () {}),
              ToolBarTile(
                icon: Icons.library_books_outlined,
                title: "Address Book",
                ontap: () {},
              ),
              ToolBarTile(
                icon: Icons.info_outline,
                title: "About",
                ontap: () {},
              ),
              ToolBarTile(
                icon: Icons.logout,
                title: "Log out",
                ontap: () {},
              ),
              TitleWidget(
                title: "Send Feedback",
                padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
                fontSize: 18,
              ),
              TitleWidget(
                title: "Report a Safety Emergency",
                padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
                fontSize: 18,
              ),
              TitleWidget(
                title: "Rate us on Play Store",
                fontSize: 18,
                padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
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
