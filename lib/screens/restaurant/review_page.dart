import 'package:cuisine_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                ReviewHandler(
                  name: "Gulshan yadav",
                  profileUrl: testUrl,
                  stars: 5,
                  review:
                      "Aliqua aute culpa fugiat enim. Dolor anim occaecat irure Lorem do qui ea nostrud culpa nulla non nisi nostrud in. Proident commodo Lorem incididunt non laboris id ullamco.",
                  reviewImage: testUrl,
                  screen: screen,
                ),
                ReviewHandler(
                  name: "Gulshan yadav",
                  profileUrl: randomImage2,
                  stars: 5,
                  review:
                      "Aliqua aute culpa fugiat enim. Dolor anim occaecat irure Lorem do qui ea nostrud culpa nulla non nisi nostrud in. Proident commodo Lorem incididunt non laboris id ullamco.",
                  reviewImage: randomImage,
                  screen: screen,
                ),
                ReviewHandler(
                  name: "Gulshan yadav",
                  profileUrl: randomImage2,
                  stars: 5,
                  review:
                      "Aliqua aute culpa fugiat enim. Dolor anim occaecat irure Lorem do qui ea nostrud culpa nulla non nisi nostrud in. Proident commodo Lorem incididunt non laboris id ullamco.",
                  reviewImage: randomImage,
                  screen: screen,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ReviewHandler extends StatelessWidget {
  const ReviewHandler({
    Key? key,
    required this.name,
    required this.profileUrl,
    required this.stars,
    required this.review,
    required this.reviewImage,
    required this.screen,
  }) : super(key: key);
  final String name;
  final String profileUrl;
  final int stars;
  final String review;
  final String reviewImage;
  final Size screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          // Profile section
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Star section
                  StarDisplayWidget(
                    filledStar: const Icon(Icons.star, color: Colors.yellow),
                    unfilledStar: const Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                    value: stars,
                  ),
                  // Image of reviews
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: screen.height * 0.17,
            width: screen.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: primaryLightColor,
              image: DecorationImage(
                image: NetworkImage(reviewImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: screen.height * 0.1,
            width: screen.width * 0.9,
            child: Text(
              review,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;

  const StarDisplayWidget({
    Key? key,
    this.value = 0,
    required this.filledStar,
    required this.unfilledStar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}
