import 'package:cuisine_app/services/login.dart';
import 'package:cuisine_app/user.dart';
import 'package:cuisine_app/widgets/toolbar_tiles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp(
      home: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          body: Container(
            color: Colors.white,
            // color: const Color(0xFF27282C),
            child: Column(
              children: [
                Container(
                  color: const Color(0xFFE3E3E3),
                  height: screenHeight / 5,
                  // color: const Color(0xFF1D1E20),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              Provider.of<User>(context, listen: false)
                                  .getUserImage),
                        ),
                        Center(
                          child: Text(
                            "Gulshan Yadav",
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              // color: Colors.white,
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
                TitleWidget(
                  title: "FOOD AND GROCERIES ORDERS",
                  padding: const EdgeInsets.fromLTRB(25, 14, 14, 0),
                  fontSize: 18,
                ),
                ToolBarTile(
                    icon: Icons.card_travel,
                    title: "Your Orders",
                    ontap: () {}),
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
                  ontap: () {
                    // AuthState.of().logout();
                  },
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
      ),
    );
  }
}

// ignore: must_be_immutable
class TitleWidget extends StatelessWidget {
  TitleWidget({
    Key? key,
    required this.title,
    required this.padding,
    required this.fontSize,
  }) : super(key: key);

  final String title;
  //  EdgeInsets padding = const EdgeInsets.fromLTRB(25, 14, 14, 0);
  EdgeInsets padding;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.lato(
            color: Colors.grey[600],
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
