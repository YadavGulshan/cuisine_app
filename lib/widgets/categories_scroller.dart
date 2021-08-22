import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double categoryHeight = MediaQuery.of(context).size.height * 0.2;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 40,
        ),
        Text(name)
      ],
    ),
  );
}
