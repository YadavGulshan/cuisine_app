import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/user/custom_drawer.dart';
import 'package:cuisine_app/screens/user/search_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/screens/user/bottomsheet.dart';
import 'package:cuisine_app/services/testing/test_cuisines.dart';
import 'package:cuisine_app/widgets/categories_scroller.dart';
import 'package:cuisine_app/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  late Future<List<RestaurantList>> futureRestaurant;

  bool _isExpanded = false;

  String _categorySubtitile = "Show more";
  Icon _expansionIcon = const Icon(Icons.expand_more_outlined);
  double _categoryHeight = 240;

  void _fetchLocation() async {
    Provider.of<CurrentLocation>(context, listen: false).getCurrenLocation();
  }

  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurant();

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentLocation provider = Provider.of<CurrentLocation>(context);
    var restaurantList;
    return Scaffold(
        body: FutureBuilder(
      future: futureRestaurant,
      builder: (context, AsyncSnapshot<List<RestaurantList>> snapshot) {
        if (snapshot.hasData) {
          restaurantList = SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var currentRestaurant = snapshot.data![index];
                return RestaurantWidget(
                  title: currentRestaurant.title,
                  imageUrl: "$baseUrl/" + currentRestaurant.imageUrl,
                  category: currentRestaurant.category.join(", "),
                  rating: currentRestaurant.reviewsAvgRating,
                  address: currentRestaurant.address,
                  slug: currentRestaurant.slug,
                  id: currentRestaurant.id.toString(),
                );
              },
              childCount: snapshot.data?.length,
            ),
          );

          /// Main screen.
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0.4,
                expandedHeight: 110,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Theme(
                                      data: Theme.of(context).copyWith(),
                                      child: const Icon(
                                          Icons.location_on_outlined),
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
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  pushNewScreen(context,
                                      screen: const MyCustomDrawer());
                                },
                                icon: Theme(
                                  data: Theme.of(context).copyWith(),
                                  child: const Icon(
                                    Icons.menu_outlined,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                            ),
                          ],
                          color: Theme.of(context).primaryColorLight,
                        ),
                        height: screenHeight * 0.055,
                        width: screenWidth * 0.9,
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
              SliverToBoxAdapter(
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(14, 0, 0, 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Popular picks",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 130,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return categoryButton(
                      TestCategory[index]["title"],
                      TestCategory[index]["imageUrl"],
                      context,
                    );
                  },
                  childCount: TestCategory.length,
                ),
              ),
              restaurantList,
            ],
          );
        } else if (snapshot.hasError) {
          //TODO: error screen.
          return const Center(
            child: Text("Something gone Wrong."),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

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
                      style: TextStyle(
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
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  TickerProvider? get vsync => null;
}

class RestaurantList {
  final int id;
  final String title;
  final String imageUrl;
  final String address;
  final String slug;
  final String reviewsAvgRating;
  List<String> category;

  RestaurantList(this.id, this.title, this.imageUrl, this.address,
      this.category, this.reviewsAvgRating, this.slug);

  RestaurantList.fromJson(Map<String, dynamic> json)
      : title = json['name'],
        id = json['id'],
        imageUrl = json['photo'],
        address = json['address'],
        category = json['category'].cast<String>(),
        slug = json['slug'],
        // String to double
        reviewsAvgRating = json["reviews_avg_rating"];
}

Future<List<RestaurantList>> fetchRestaurant() async {
  final http.Response response =
      await http.get(Uri.parse("$baseUrl/api/restaurants"));

  if (response.statusCode == 200) {
    List<dynamic> result = jsonDecode(response.body);
    // List<dynamic> restaurantInfo = result[''];
    return result.map((e) => RestaurantList.fromJson(e)).toList();
  } else {
    /// Nothing found.
    throw Exception("Something gone wrong");
  }
}

/*
"id": 1,
            "name": "Admin",
            "slug": "-----",
            "category": "-----",
            "photo": "storage/images/admin.png",
            "phone": "0",
            "email": "gowtham@domain.com",
            "owner": "Admin",
            "isBanned": 0,
            "address": "---------",
            "city": "---",
            "state": "---",
            "zip": 0,
            "latitude": null,
            "longitude": null,
            "isAdmin": 1,
            "created_at": "2021-08-30T04:51:30.000000Z",
            "updated_at": "2021-08-30T04:51:30.000000Z"
*/