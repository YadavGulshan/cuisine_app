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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    // Review about the restaurant.

                    // TODO: Use bottom sheet to ask the review from the user.
                    Container(
                      height: screen.height * 0.068,
                      width: screen.width,
                      decoration: BoxDecoration(
                        color: primaryLightColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: TextFormField(
                        cursorHeight: 30,
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              bottom: 10, top: 10, left: 0, right: 0),
                          icon: Padding(
                              padding: const EdgeInsets.only(
                                left: 2,
                                right: 0,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.attachment),
                                onPressed: () {},
                              )),
                          // hintText:,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              top: 8,
                              right: 8,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                child: const Text("Comment"),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Reviews goes here..
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
            ],
          ),
        ),
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
                    style: TextStyle(
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
