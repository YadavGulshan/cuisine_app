import 'package:cuisine_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<dynamic> bottomSheet(BuildContext context, double height) {
  return showModalBottomSheet(
      // backgroundColor: Colors.red,
      context: context,
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(10.0),
      ),
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: height * 0.7,
          decoration: BoxDecoration(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 0, 4),
                child: Text(
                  "Search location",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SearchBar(
                hinttext: "Search for your location",
                searchIcon: true,
                autofocus: false,
                edgeInsetsGeometry: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                blurRadius: 0.8,
              )
            ],
          ),
        );
      });
}
