import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/widgets/topbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: topBar(context),
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
          )
        ],
      ),
    );
  }
}
