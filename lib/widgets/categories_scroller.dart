import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double categoryHeight = MediaQuery.of(context).size.height * 0.2;
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: <Widget>[
            categoryButton("Category", testUrl),
            categoryButton("Category", testUrl),
            categoryButton("Category", testUrl),
            categoryButton("Category", testUrl),
          ],
        ),
      ),
    );
  }
}

Widget categoryButton(
  // double screenHeight,
  // double screenWidth,
  String name,
  String imageUrl,
) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
            child: const SizedBox(
              height: 80,
              width: 80,
            ),
            baseColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColorLight),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        child: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}
