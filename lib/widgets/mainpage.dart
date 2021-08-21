import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/custom_drawer.dart';
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
          leading: IconButton(
              onPressed: () {
                bottomSheet(context, screenHeight / 1.2);
              },
              icon: const Icon(Icons.location_on_outlined, color: topBarColor)),
          title: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Text(
              widget.address,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.lato(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: topBarColor,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  pushNewScreen(context, screen: const MyCustomDrawer());
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        // Categories section
        SliverToBoxAdapter(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: 1.0,
            child: const CategoriesScroller(),
          ),
        ),

        // List of products
        Cuisine(screenHeight: screenHeight, screenWidth: screenWidth)
      ],
    );
  }
}

Widget categoryButton(
    double screenHeight, double screenWidth, String name, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: screenHeight / 6,
        width: screenWidth / 4,
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              foregroundImage: NetworkImage(imageUrl),
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                  // color:
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
