import 'package:cuisine_app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

Widget topBar(BuildContext context) {
  var height2 = MediaQuery.of(context).size.height;
  var width2 = MediaQuery.of(context).size.width;
  return SizedBox(
    height: height2 / 16,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                bottomSheet(context, height2);
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: topBarColor,
                    ),
                  ),
                  SizedBox(
                    width: width2 / 1.5,
                    child: Text(
                      "Patlipada Village, Thane West",
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
                ],
              ),
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}
