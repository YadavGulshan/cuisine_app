import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/restaurant/delivery_page.dart';
import 'package:cuisine_app/screens/restaurant/review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantPage extends StatefulWidget {
  final String title;
  String address;
  double rating;
  int restaurantId;
  String category;
  String imageUrl;
  RestaurantPage(
      {Key? key,
      required this.restaurantId,
      required this.title,
      required this.address,
      required this.rating,
      required this.imageUrl,
      this.category = ""})
      : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>['Delivery', 'Reviews'];
    Size screen = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  elevation: 0.2,
                  expandedHeight: screen.height * 0.3,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      color: myprimarylightColor,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(testUrl),
                          fit: BoxFit.cover,
                        )),
                        child: BackdropFilter(
                          // blendMode: BlendMode.darken,
                          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.0),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Icon section.
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined),
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Title section
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              widget.title,
                                              style: GoogleFonts.lato(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.black,
                                                  color: primaryColor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 2,
                                            ),
                                            child: Text(
                                              widget.category,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            widget.address,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // rating
                                    Container(
                                      height: screen.height * 0.05,
                                      width: screen.width * 0.15,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.rating.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              // textAlign: TextAlign.center,
                                            ),
                                            const Icon(Icons.star,
                                                color: Colors.white, size: 18)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TabBar(
                        labelColor: Colors.black,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        tabs: const [
                          Tab(
                            text: "Delivery",
                          ),
                          Tab(
                            text: "Reviews",
                          )
                        ],
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: const TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: [
              DeliveryPage(),
              ReviewPage(),
            ],
          ),
        ),
      ),
    );
  }
}
