import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/restaurant_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.category,
      required this.rating,
      required this.address,
      this.showRating = true,
      required this.id})
      : super(key: key);
  final String title;
  final String imageUrl;
  final String category;
  final String rating;
  final String address;
  final String id;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        pushNewScreen(context,
            screen: RestaurantPage(
              restaurantId: id,
              imageUrl: imageUrl,
              title: title,
              address: address,
              rating: rating,
              category: category,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: Container(
          height: screenHeight * 0.3 + 10,
          decoration: BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
              width: 3,
            ),
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                height: screenHeight * 0.2,

                /// TODO: Breakpoint
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(height: screenHeight * 0.2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(
                // color: Colors.black,
                height: screenHeight * 0.09 + 10,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              // height: screenHeight * 0.05,
                              width: screenWidth * 0.5,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: Text(
                              category,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    (showRating)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        rating,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
