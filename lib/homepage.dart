import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
                child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: topBar,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                "Patlipada Village, Thane West",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  decorationColor: topBar,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
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
                    icon: const Icon(Icons.menu_rounded),
                  )
                ],
              ),
            )),
          ),
          SliverAppBar(
            title: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
