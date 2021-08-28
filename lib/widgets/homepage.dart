// ignore_for_file: implementation_imports

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/user/search_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/widgets/bottomsheet.dart';
import 'package:cuisine_app/widgets/categories_scroller.dart';
import 'package:cuisine_app/widgets/homepage_cuisines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];

  void _fetchLocation() async {
    Provider.of<CurrentLocation>(context, listen: false).getCurrenLocation();
  }

  @override
  void initState() {
    super.initState();
    // Fetch the location.
    _fetchLocation();
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
    // Get the location from the provider.
    CurrentLocation provider = Provider.of<CurrentLocation>(context);

    // Screen size.
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Using slivers for better User experience.
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0.4,
          expandedHeight: 110,
          // toolbarHeight: 150,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryLightColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Location icon button. It will open the bottom sheet.
                            IconButton(
                              icon: Theme(
                                data: Theme.of(context).copyWith(),
                                child: const Icon(Icons.location_on_outlined),
                              ),
                              onPressed: () {
                                bottomSheet(context, screenHeight);
                              },
                            ),
                            SizedBox(
                              height: 20,
                              width: screenWidth * 0.65,
                              child: Text(
                                provider.address,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  fontSize: 17,
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
                          ],
                        ),
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
                  ],
                ),
              ),
            ),
          ),
          bottom: PreferredSize(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),

                  // box shadow
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                    ),
                  ],
                  color: primaryLightColor,
                ),
                height: screenHeight * 0.055,
                width: screenWidth * 0.9,

                // Search bar button.
                child: InkWell(
                  onTap: () {
                    pushNewScreen(context, screen: const SearchPage());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.search_outlined,
                        ),
                        Text("Restaurant name, cuisine and more"),
                      ],
                    ),
                  ),
                )),
            preferredSize: const Size.fromHeight(0),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Eat what makes you happy",
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 0.6,
                    ),
                  ),
                ),
              ),
              const AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: 1.0,
                child: CategoriesScroller(),
              ),
            ],
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

// An app bar having title and search field

class SearchBar implements SliverPersistentHeaderDelegate {
  SearchBar({required this.minExtent, required this.maxExtent});
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              color: primaryLightColor,
              height: maxExtent,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search for a Cuisine",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: (appTheme == Brightness.light)
                            ? Colors.grey[600]
                            : Colors.white,
                      ),
                    ),
                    Theme(
                        data: Theme.of(context).copyWith(),
                        child: const Icon(Icons.search_outlined)),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    // throw UnimplementedError();
    return true;
  }

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider? get vsync => null;
}
