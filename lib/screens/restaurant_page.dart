import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/order/cart.dart';
import 'package:cuisine_app/screens/order/cart_bottomscreen.dart';
import 'package:cuisine_app/screens/restaurant/delivery_page.dart';
import 'package:cuisine_app/screens/restaurant/review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantPage extends StatefulWidget {
  String title;
  String address;
  String rating;
  String restaurantId;
  String category;
  String imageUrl;
  String slug;
  RestaurantPage(
      {Key? key,
      required this.restaurantId,
      required this.title,
      required this.address,
      required this.rating,
      required this.imageUrl,
      required this.slug,
      this.category = ""})
      : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  void _updatePaletteGenerator() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(widget.imageUrl).image,
    );
    debugPrint(paletteGenerator.colors.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    // Delete the cart content.
    Provider.of<CartModel>(context, listen: false).removeAllItems();
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
                  elevation: 10,
                  expandedHeight: screen.height * 0.4,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        child: Container(
                          height: screen.height * 0.17,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        baseColor: primaryColor,
                        highlightColor: Theme.of(context).primaryColorLight,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(75 + 27),
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
                controller: _controller,
                children: [
                  DeliveryPage(
                    restaurantid: widget.slug,
                  ),
                  ReviewPage(
                    restaurant: widget.slug,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton:
            (Provider.of<CartModel>(context, listen: true).totalQuantity != 0)
                ? FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      pushNewScreen(context, screen: const CartPage());
                    },
                    child: Badge(
                      badgeColor: Colors.white,
                      animationType: BadgeAnimationType.fade,
                      badgeContent: Text(
                          Provider.of<CartModel>(context, listen: true)
                              .totalQuantity
                              .toString()),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: primaryLightColor,
                      ),
                    ))
                : null,
      ),
    );
  }

  Widget headSection(Color? face, Size screen) {
    var textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    child: SizedBox(
                      width: screen.width * 0.5,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: SizedBox(
                      width: screen.width * 0.8,
                      child: Text(
                        widget.category,
                        style: textStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screen.width * 0.8,
                    child: Text(
                      widget.address,
                      style: textStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
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
                    Text(widget.rating,
                        style: const TextStyle(color: Colors.white)),
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
          tabs: [
            Tab(
              child: Text(
                "Delivery",
                style: TextStyle(
                  fontSize: screen.height * 0.022,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Reviews",
                style: TextStyle(
                  fontSize: screen.height * 0.022,
                ),
              ),
            )
          ],
          controller: _controller,
        ),
      ],
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
