import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/restaurant/delivery_page.dart';
import 'package:cuisine_app/screens/restaurant/review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

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
  // Generate palette from the image.
  Color? headColor =
      (appTheme == Brightness.light) ? Colors.white : Colors.grey[800];
  void _updatePaletteGenerator() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(widget.imageUrl).image,
    );
    debugPrint(paletteGenerator.colors.toString());
    setState(() {
      headColor = paletteGenerator.dominantColor as Color?;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    // _updatePaletteGenerator();
  }

  @override
  Widget build(BuildContext context) {
    //
    final List<String> _tabs = <String>['Delivery', 'Reviews'];
    Size screen = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          // physics: const ClampingScrollPhysics(
          //   parent: AlwaysScrollableScrollPhysics(),
          // ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  elevation: 10,
                  expandedHeight: screen.height * 0.4,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    // collapseMode: CollapseMode.pin,
                    background: Container(
                      color: primaryLightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  const Icon(Icons.arrow_back_ios_new_outlined),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(72),
                    // child: FutureBuilder<PaletteGenerator>(
                    //   future: _updatePaletteGenerator(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<PaletteGenerator> snapshot) {
                    //     switch (snapshot.connectionState) {
                    //       case ConnectionState.waiting:
                    //         return headSection(
                    //             (appTheme == Brightness.light)
                    //                 ? Colors.white24
                    //                 : Colors.black26,
                    //             textStyle,
                    //             screen);
                    //       default:
                    //         if (snapshot.hasError) {
                    //           return headSection(
                    //               (appTheme == Brightness.light)
                    //                   ? Colors.white24
                    //                   : Colors.black26,
                    //               textStyle,
                    //               screen);
                    //         } else {
                    //           var face = snapshot.data?.dominantColor?.color;
                    //           return headSection(face, textStyle, screen);
                    //         }
                    //     }
                    //   },
                    // ),
                    // child: headSection(headColor, screen),
                    child: headSection(Colors.black, screen),
                  ),
                ),
              )
            ];
          },
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light
                .copyWith(statusBarColor: Colors.white10),
            child: SafeArea(
              child: TabBarView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: _controller,
                children: const [
                  // DeliveryPage(),
                  // FutureBuilder<PaletteGenerator>(
                  //     future: _updatePaletteGenerator(), // async work
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<PaletteGenerator> snapshot) {
                  //       switch (snapshot.connectionState) {
                  //         case ConnectionState.waiting:
                  //           return const Center(child: CircularProgressIndicator());
                  //         default:
                  //           if (snapshot.hasError) {
                  //             return Text('Error: ${snapshot.error}');
                  //           } else {
                  //             // Color color=new Color(snapshot.data.dominantColor.color);
                  //             var face = snapshot.data?.dominantColor?.color;
                  //             return Center(
                  //               child: Container(
                  //                   color: face,
                  //                   height: 20,
                  //                   child: Text('color: ${face.toString()}')),
                  //             );
                  //           }
                  //       }
                  //     }),
                  DeliveryPage(),
                  ReviewPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headSection(Color? face, Size screen) {
    var textStyle = GoogleFonts.lato(
      color: Colors.white,
      // color: (appTheme == Brightness.light) ? Colors.black : Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: 9,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title section
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          color: Colors.white,
                          // color: (appTheme == Brightness.light)
                          //     ? Colors.black
                          //     : Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 2,
                      ),
                      child: Text(
                        widget.category,
                        style: textStyle,
                      ),
                    ),
                    Text(
                      widget.address,
                      style: textStyle,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.rating.toString(),
                          style: const TextStyle(color: Colors.white)
                          // textAlign: TextAlign.center,
                          ),
                      const Icon(Icons.star, color: Colors.white, size: 18)
                    ],
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            automaticIndicatorColorAdjustment: true,
            indicatorWeight: 4,
            labelColor: Colors.white,
            // labelColor:
            //     (appTheme == Brightness.light) ? Colors.black : Colors.white,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            tabs: [
              Tab(
                child: Text(
                  "Delivery",
                  style: TextStyle(
                    fontSize: screen.height * 0.022,
                  ),
                ),
                // child: customTabLabel(screen, "Delivery"),
              ),
              Tab(
                child: Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: screen.height * 0.022,
                  ),
                ),
                // child: customTabLabel(screen, "Reviews"),
              )
            ],
            controller: _controller,
          ),
        ],
      ),
    );
  }

  Container customTabLabel(Size screen, String text) {
    return Container(
      height: screen.height * 0.05,
      width: screen.width * 0.5,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: screen.height * 0.022,
          ),
        ),
      ),
    );
  }
}
