// ignore_for_file: implementation_imports
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/user/custom_drawer.dart';
import 'package:cuisine_app/screens/user/search_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/screens/user/bottomsheet.dart';
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
  final logoutCallback;

  const MainPage({
    this.logoutCallback,
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
  String address = "";

  // Category section
  bool _isExpanded = false;
// Our category section
  String _categorySubtitile = "Show more";
  Icon _expansionIcon = const Icon(Icons.expand_more_outlined);
  double _categoryHeight = 240;

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
    // Screen size.
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentLocation provider = Provider.of<CurrentLocation>(context);

    // Network service for fetching data.
    // final NetworkService restaurantData = NetworkService();
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
                decoration: BoxDecoration(
                  color: (appTheme == Brightness.light)
                      ? primaryLightColor
                      : Colors.grey[850],
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
                                provider.addressStatus,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  decoration: TextDecoration.underline,
                                  // color: (appTheme == Brightness.light)
                                  //     ? Colors.black
                                  //     : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: IconButton(
                            onPressed: () {
                              pushNewScreen(context,
                                  screen: const MyCustomDrawer());
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

          // Seatch button here.
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),

                    // box shadow
                    boxShadow: [
                      BoxShadow(
                        color: (appTheme == Brightness.light)
                            ? Colors.grey
                            : Colors.transparent,
                        blurRadius: 4.0,
                      ),
                    ],
                    color: (appTheme == Brightness.light)
                        ? primaryLightColor
                        : Colors.grey[850],
                  ),
                  height: screenHeight * 0.055,
                  width: screenWidth * 0.9,

                  // When search bar is clicked, it will route search page.
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
            ),
            preferredSize: const Size.fromHeight(8),
          ),
        ),

        // Some banner.

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            child: Container(
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Colors.amber,
                image: DecorationImage(
                  image: NetworkImage(
                    bannerImageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        /// Head Section.
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
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

              // Category section
              // TODO: Changed it to a expandable box using animated container.
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 5000),
                  curve: Curves.easeInBack,
                  // height: screenHeight * 0.55, // expanded height
                  height: _categoryHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                      // color: Colors.transparent,
                      ),
                  child: Wrap(
                    children: [
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                      categoryButton("Category", testUrl),
                    ],
                  ),
                ),
              ),
              // Our button
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 20),
                child: InkWell(
                  onTap: () {
                    if (_isExpanded == false) {
                      setState(() {
                        _isExpanded = true;
                        _categoryHeight = 340;
                        _categorySubtitile = "show less";
                        _expansionIcon = const Icon(
                          Icons.expand_less_outlined,
                        );
                      });
                      debugPrint(
                          "#############_isExpanded: $_isExpanded ###############");
                    } else {
                      setState(() {
                        _isExpanded = false;
                        _categoryHeight = 240;
                        _categorySubtitile = "show more";
                        _expansionIcon = const Icon(Icons.expand_more_outlined);
                      });
                      debugPrint(
                          "#############_isExpanded: $_isExpanded ###############");
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 2000),
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: (appTheme == Brightness.light)
                            ? myprimarylightColor
                            : Colors.grey,
                        width: 1,
                      ),
                    ),
                    curve: Curves.bounceInOut,
                    height: screenHeight * 0.03,
                    child: Center(
                      // TODO: Add a logic that will be used when container is expaned and collapsed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _categorySubtitile,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                            ),
                          ),
                          _expansionIcon,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Restaurant(
            title: "Pizzzza",
            imageUrl: testUrl,
            category: "Eat this Third Class pizza"),
        Restaurant(
            title: "Pizzzza",
            imageUrl: testUrl,
            category: "Eat this Third Class pizza"),
        Restaurant(
            title: "Pizzzza",
            imageUrl: testUrl,
            category: "Eat this Third Class pizza"),

        // Products here...
        // SliverList(
        //   delegate: SliverChildListDelegate(
        //     [
        //       FutureBuilder(
        //         future: fetchData(),
        //         builder:
        //             (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
        //           debugPrint("############Fetching##################");
        //           if (snapshot.hasData) {
        //             return ListView.builder(
        //                 itemCount: snapshot.data!.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   var currentRestaurant = snapshot.data![index];
        //                   debugPrint(currentRestaurant.toString());
        //                   return Restaurant(
        //                     title: currentRestaurant.name,
        //                     category: currentRestaurant.category,
        //                     imageUrl: currentRestaurant.photo,
        //                     key: Key(
        //                       currentRestaurant.id
        //                           .toString(), // Key for later use.
        //                     ),
        //                     // TODO: Implement the is banned and remaining stuff too.
        //                   );
        //                 });
        //           }
        //           // } else if (snapshot.hasError) {
        //           //   return const FlutterLogo(); // TODO: Add a error page.
        //           // }
        //           return const Center(
        //               child: CircularProgressIndicator()); // Loaded screen.
        //         },
        //         // TODO: Add shimmer animation.
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}

// An app bar having title and search field

class HomeSearchBar implements SliverPersistentHeaderDelegate {
  HomeSearchBar({required this.minExtent, required this.maxExtent});
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
