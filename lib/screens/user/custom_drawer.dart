import 'package:cuisine_app/main.dart';
import 'package:cuisine_app/provider/authstream1.dart';
import 'package:cuisine_app/screens/auth/auth_page.dart';
import 'package:cuisine_app/screens/order/cart.dart';
import 'package:cuisine_app/screens/user/myorders.dart';
import 'package:cuisine_app/screens/user/profile_section.dart';
import 'package:cuisine_app/widgets/toolbar_tiles.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    AuthService provider = Provider.of(context, listen: false);
    Size screen = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        drawerEnableOpenDragGesture: false,
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
                                  child: Text(
                                    provider.userName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 22, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: screen.width * 0.6,
                                  child: Text(
                                    provider.userEmail,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
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
            Divider(
              endIndent: 50,
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
            // TitleWidget(
            //   title: "FOOD AND GROCERIES ORDERS",
            //   padding: const EdgeInsets.fromLTRB(25, 14, 14, 0),
            //   fontSize: 18,
            // ),
            ToolBarTile(
                icon: Icons.manage_accounts,
                title: "Manage Profile",
                ontap: () {
                  pushNewScreen(context, screen: ManageProfile());
                }),
            ToolBarTile(
                icon: Icons.card_travel,
                title: "My Orders",
                ontap: () {
                  // Open cart page
                  pushNewScreen(context, screen: const MyOrders());
                  // Navigator.(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const MyOrders()));
                }),
            // ToolBarTile(
            //   icon: Icons.settings_outlined,
            //   title: "Settings",
            //   ontap: () {
            //     openAppSettings();
            //   },
            // ),
            // ToolBarTile(
            //   icon: Icons.info_outline,
            //   title: "About",
            //   ontap: () {},
            // ),
            ToolBarTile(
              icon: Icons.logout,
              title: "Log out",
              ontap: () {
                provider.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => const GetStartedPage()));
                // Navigator.pop(context);
              },
            ),
            const Divider(
              endIndent: 90,
            ),
            TitleWidget(
              title: "Send Feedback",
              padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
              fontSize: 18,
              toshowSnackbar: true,
              color: Colors.green,
              message: "Work in Progress",
            ),
            TitleWidget(
              title: "Report a Safety Emergency",
              padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
              fontSize: 18,
              // ontap: _launchCaller,
              toshowSnackbar: true,
              color: Colors.red,
              message: 'Dial "100"!',
            ),
            TitleWidget(
              title: "Rate us on Play Store",
              fontSize: 18,
              padding: const EdgeInsets.fromLTRB(25, 16, 14, 0),
              toshowSnackbar: true,
              message: "Thanks for rating us.",
              color: Colors.blueAccent,
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
    this.color = Colors.black,
    this.message = "",
    this.toshowSnackbar = false,
  }) : super(key: key);

  final String title;
  final Color color;
  final String message;
  EdgeInsets padding;
  final double fontSize;
  final bool toshowSnackbar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: () {
          if (toshowSnackbar) {
            SnackBar snackBar = SnackBar(
              content: Text(message),
              backgroundColor: color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
