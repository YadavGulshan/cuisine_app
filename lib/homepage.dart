import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/widgets/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widgets/toolbar_tiles.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _fetchLocation() async {
    Provider.of<CurrentLocation>(context, listen: false).getCurrenLocation();
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    String address = Provider.of<CurrentLocation>(context).addressStatus;
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // double value = 0;
    return Scaffold(
      body: MainPage(
        address: address,
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
