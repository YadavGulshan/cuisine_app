import 'package:cuisine_app/provider/authstream.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/widgets/toolbar_tiles.dart';
import 'package:flutter/cupertino.dart';
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
    AuthState provider = Provider.of<AuthState>(context);
    Size screen = MediaQuery.of(context).size;
    // double screenWidth = MediaQuery.of(context).size.width;
    // var color =
    //     (appTheme == Brightness.light) ? Colors.white : Colors.grey[850];

    return MaterialApp(
      home: Scaffold(
        body: Container(
          // color: color,
          child: Column(
            children: [
              Container(
                // color: const Color(0xFFE3E3E3),
                // color: color,
                height: screen.height * 0.22,
                // color: const Color(0xFF1D1E20),
                child: SafeArea(
                  child: Container(
                    // color: (appTheme == Brightness.light)
                    //     ? primaryLightColor
                    //     : Colors.grey[850],
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_outlined,
                                  // color: Color(0xFFB2B1B6),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  provider.profileUrl,
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: screen.width * 0.7,
                                      child: Text(
                                        provider.username,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 22,
                                          // color: (appTheme == Brightness.light)
                                          //     ? Colors.black
                                          //     : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screen.width * 0.6,
                                      child: Text(
                                        provider.emailAddr,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          // color: (appTheme == Brightness.light)
                                          //     ? Colors.black
                                          //     : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TitleWidget(
                title: "FOOD AND GROCERIES ORDERS",
                padding: const EdgeInsets.fromLTRB(25, 14, 14, 0),
                fontSize: 18,
              ),
              ToolBarTile(
                  icon: Icons.card_travel, title: "Your Orders", ontap: () {}),
              ToolBarTile(
                  icon: Icons.favorite_border_outlined,
                  title: "Favourite Orders",
                  ontap: () {}),
              ToolBarTile(
                icon: Icons.settings_outlined,
                title: "Settings",
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
                  provider.logoutAction();
                  Navigator.pop(context);
                },
              ),
              const Divider(
                endIndent: 90,
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
          style: TextStyle(
            fontSize: fontSize,
            // color: (appTheme == Brightness.light) ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
