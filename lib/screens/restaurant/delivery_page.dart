import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              menu(screen, true, "Pan Cake", 60),
              menu(screen, true, "Pizza", 0),
              menu(screen, true, "Burger", 200),
              menu(screen, true, "French Fries", 50),
              menu(screen, true, "Grilled Pan", 50),
              menu(screen, true, "Grilled Pan", 50),
              menu(screen, true, "Grilled Pan", 50),
              menu(screen, true, "Grilled Pan", 50),
              menu(screen, true, "Grilled Pan", 50),
              menu(screen, true, "Grilled Pan", 50),
            ],
          ),
        )
      ],
    );
  }
}

Widget menu(Size screen, bool isVeg, String title, int price) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
    child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.08))),
        // color: Colors.green,
        height: screen.height * 0.1,
        width: screen.width * 0.99,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 1),
                //   child: SvgPicture.asset(
                //     "assets/category.svg",
                //     color: (isVeg) ? Colors.greenAccent : Colors.red,
                //     height: screen.height * 0.026,
                //   ),
                // ),
                Text(
                  title,
                  style: GoogleFonts.lato(fontSize: 20),
                ),
                Text(
                  "₹" + price.toString(),
                )
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryColor, width: 1, style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: (appTheme == Brightness.light)
                      ? primaryLightColor
                      : Colors.blue,
                ),
                height: screen.height * 0.04,
                width: screen.width * 0.2,
                child: const Center(
                  // child: Icon(Icons.add),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("ADD"),
                  ),
                ),
              ),
            )
          ],
        )),
  );
}
