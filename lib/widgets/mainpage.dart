import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/custom_drawer.dart';
import 'package:cuisine_app/screens/search_page.dart';
import 'package:cuisine_app/widgets/bottomsheet.dart';
import 'package:cuisine_app/widgets/categories_scroller.dart';
import 'package:cuisine_app/widgets/homepage_cuisines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.address}) : super(key: key);
  String address;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0.4,
          floating: true,
          leading: IconButton(
            icon: Theme(
              data: Theme.of(context).copyWith(),
              child: const Icon(Icons.location_on_outlined),
            ),
            onPressed: () {
              // bottomSheet(context, 20);
            },
          ),
          title: SizedBox(
            height: 20,
            width: screenWidth * 0.6,
            child: Text(
              widget.address,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                decorationStyle: TextDecorationStyle.dotted,
                decoration: TextDecoration.underline,
                color: (appTheme == Brightness.light)
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          actions: [
            // Menu Icon button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  bottomSheet(context, screenHeight / 1.2);
                },
                icon: Theme(
                  data: Theme.of(context).copyWith(),
                  child: const Icon(
                    Icons.menu_outlined,
                    // color: topBarColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Categories section
        const SliverToBoxAdapter(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: 1.0,
            child: CategoriesScroller(),
          ),
        ),

        // List of products
        Cuisine(screenHeight: screenHeight, screenWidth: screenWidth),
        Cuisine(screenHeight: screenHeight, screenWidth: screenWidth),
        Cuisine(screenHeight: screenHeight, screenWidth: screenWidth),
        Cuisine(screenHeight: screenHeight, screenWidth: screenWidth),
      ],
    );
  }
}
