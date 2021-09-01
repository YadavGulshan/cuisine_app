import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/restaurant/delivery_page.dart';
import 'package:cuisine_app/screens/restaurant/review_page.dart';
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
    Size screen = MediaQuery.of(context).size;
    var fontColor =
        (appTheme == Brightness.light) ? Colors.grey[550] : Colors.white;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        // shrinkWrap: true,

        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.2,
            expandedHeight: 180,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: myprimarylightColor,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Icon section.
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title section
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 4,
                                    ),
                                    child: Text(widget.title,
                                        style: GoogleFonts.varelaRound(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 2,
                                    ),
                                    child: Text(widget.category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ),
                                  Text(widget.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
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
          SliverFillRemaining(
            child: TabBarView(
              controller: _controller,
              children: const [
                DeliveryPage(),
                ReviewPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
