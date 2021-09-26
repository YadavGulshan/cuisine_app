import 'package:cuisine_app/widgets/toolbar_tiles.dart';
import 'package:flutter/material.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: screen.height * 0.22,
              child: SafeArea(
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
                            )),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              size: 40,
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screen.width * 0.7,
                                  child: const Text(
                                    "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screen.width * 0.6,
                                  child: const Text(
                                    "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
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
    );
  }
}

class TitleWidget extends StatelessWidget {
  TitleWidget({
    Key? key,
    required this.title,
    required this.padding,
    required this.fontSize,
  }) : super(key: key);

  final String title;

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
          ),
        ),
      ),
    );
  }
}
