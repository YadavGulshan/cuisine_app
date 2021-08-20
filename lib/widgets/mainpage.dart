import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/screens/custom_drawer.dart';
import 'package:cuisine_app/widgets/bottomsheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.address}) : super(key: key);
  String address;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverAppBar(
          leading: IconButton(
              onPressed: () {
                bottomSheet(context, screenHeight / 1.2);
              },
              icon: const Icon(Icons.location_on_outlined, color: topBarColor)),
          title: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Text(
              widget.address,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.lato(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: topBarColor,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  pushNewScreen(context, screen: const MyCustomDrawer());
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
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
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 20,
                          ),
                          // Spacer(),
                          Text(
                            "Cuisines, restaurants, and more",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                          // Text("$long $lat"),
                          // Text(widget.address),
                          // Spacer(
                          //   flex: 2,
                          // ),
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
                textColor: topBarColor,
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
