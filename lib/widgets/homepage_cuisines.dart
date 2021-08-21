import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cuisine extends StatelessWidget {
  const Cuisine({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 35),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
              height: screenHeight * 0.35,
              // width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey[800],
              ),
              child: Column(
                children: [
                  // Image goes here.
                  Container(
                    height: screenHeight * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?crop=entropy&cs=srgb&dl=pexels-daria-shevtsova-704569.jpg&fit=crop&fm=jpg&h=853&w=640",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),

                  // Name Description and price.
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: screenWidth * 0.5,
                              // color: Colors.red,
                              child: Text(
                                "Pasta shcoeo",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: screenWidth * 0.5,
                              child: Text("Tasty Pasta"),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: screenHeight / 24,
                            width: screenWidth / 7,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                "20000",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  // fontWeight: FontWeight.bold,
                                  // fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
