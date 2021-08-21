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
        padding: const EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
              height: screenHeight / 4,
              // width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                  // Image goes here.
                  Container(
                    height: screenHeight / 7,
                    color: Colors.red,
                  ),

                  // Name Description and price.
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Text(
                              "Hey",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Text("Name of Restaurant")
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
