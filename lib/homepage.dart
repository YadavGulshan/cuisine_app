import 'dart:ui';
import 'package:cuisine_app/widgets/topbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    required this.longitude,
    required this.latitude,
    required this.address,
  }) : super(key: key);
  final String longitude;
  final String latitude;
  final String address;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var long = widget.longitude;
    var lat = widget.latitude;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            title: topBar(context, widget.address),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  strokeWidth: 0.3,
                  strokeCap: StrokeCap.round,
                  radius: const Radius.circular(22),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: InkWell(
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: Container(
                        height: screenHeight / 21,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                size: 20,
                              ),
                            ),
                            Spacer(),
                            Text("Cuisines, restaurants, and more"),
                            // Text("$long $lat"),
                            // Text(widget.address),
                            Spacer(),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ExpansionTile(
                  leading: Image.asset(
                    "assets/category_logo.jpg",
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    "Categories",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 28,
                    ),
                  ),
                  initiallyExpanded:
                      true, // TODO: if children inside the wrapper is more than 8 then prefer initially expanded to false.
                  children: [
                    Wrap(
                      children: [
                        // TODO: Use future builder here, by returning categoryButton
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640"),
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg?cs=srgb&dl=pexels-william-choquette-2641886.jpg&fm=jpg"),
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640"),
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640"),
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640"),
                        categoryButton(screenHeight, screenWidth, "Category",
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget categoryButton(
    double screenHeight, double screenWidth, String name, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: screenHeight / 6,
        width: screenWidth / 4,
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              foregroundImage: NetworkImage(imageUrl),
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                  // color:
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
