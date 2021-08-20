import 'package:cuisine_app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.address,
    required this.ontap,
  }) : super(key: key);

  final String address;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    var height2 = MediaQuery.of(context).size.height;
    var width2 = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height2 / 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // IconButton(
          //   onPressed: ontap,
          //   icon: const Icon(
          //     Icons.menu_rounded,
          //     color: Colors.black,
          //   ),
          // ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  bottomSheet(context, height2);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width2 / 1.5,
                      child: Text(
                        address,
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
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: topBarColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
