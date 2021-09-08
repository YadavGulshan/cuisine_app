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
      required this.id})
      : super(key: key);
  final String title;
  final String imageUrl;
  final String category;
  final String rating;
  final String address;
  final String id;

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
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 2),

        // Elevation is used to create shadow on the card
        child: Container(
          height: screenHeight * 0.35,
          // height: 250,
          // width: screenWidth * 0.9,
          decoration: BoxDecoration(
            // color: (appTheme == Brightness.light)
            //     ? primaryLightColor
            //     : Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              // color: (appTheme == Brightness.light)
              //     ? primaryLightColor
              //     : Colors.transparent,
              color: primaryLightColor,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              // Image goes here.
              // Container(
              //   height: screenHeight * 0.23,
              //   decoration: BoxDecoration(
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(12),
              //   topRight: Radius.circular(12),
              // ),
              //     image: DecorationImage(
              //         image: NetworkImage(imageUrl), fit: BoxFit.cover),
              //   ),
              // ),
              CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: screenHeight * 0.23,
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
                // placeholder: (context, url) => Container(
                //   decoration: const BoxDecoration(
                //     color: Colors.grey,
                //   ),
                // ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(height: screenHeight * 0.23),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

              // Name Description and price.
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Title of restaurant
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 20,
                            width: screenWidth * 0.5,
                            // color: Colors.red,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        // SHort description
                        SizedBox(
                          height: 40,
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
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: screenHeight / 24,
                            width: screenWidth / 6.5,
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rating, // rating. // TODO: Implement rating later.
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    // fontWeight: FontWeight.bold,
                                    // fontSize: 18,
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
                        ),
                        // Price section.
                        // Text("₹200 for one",
                        //     style: GoogleFonts.lato(
                        //       color: Colors.grey,
                        //     ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
