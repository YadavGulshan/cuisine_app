import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ReviewPage extends StatefulWidget {
  String restaurant;
  ReviewPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late Future<List<RestaurantReview>> futureReviews;

  @override
  void initState() {
    super.initState();
    futureReviews = fetchRestaurantReviews(widget.restaurant);
  }

  @override
  Widget build(BuildContext context) {
    var restaurantReview;
    Size screen = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureReviews,
      builder: (context, AsyncSnapshot<List<RestaurantReview>> snapshot) {
        if (snapshot.hasData) {
          debugPrint("Snapshot has data");
          debugPrint(snapshot.data![0].review.toString());
          restaurantReview = SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // var currentRestaurantReview = snapshot.data![index];
                debugPrint("######################### Review:" +
                    snapshot.data![index].review +
                    "\n");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReviewHandler(
                    // profileUrl: snapshot.data![index].imageUrl,
                    review: snapshot.data![index].review,
                    // reviewImage: "$baseUrl/" + snapshot.data![index].imageUrl,
                    stars: snapshot.data![index].rating,
                    name: snapshot.data![index].customerid,
                  ),
                );
              },
              childCount: snapshot.data?.length,
            ),
          );
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber
                // above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      // Review about the restaurant.

                      // TODO: Use bottom sheet to ask the review from the user.
                      Container(
                        height: screen.height * 0.068,
                        width: screen.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          // cursorHeight: 30,
                          style: const TextStyle(fontSize: 20),
                          maxLines: 50,
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.only(
                            //     bottom: 0, top: 10, left: 0, right: 0),
                            icon: Padding(
                                padding: const EdgeInsets.only(
                                  // left: 2,
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
                                  child: const Text(
                                    "Review",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onPressed: () {
                                    // Snackbar
                                    SnackBar snackBar = const SnackBar(
                                      content: Text(
                                        "Review submitted!",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              restaurantReview,
            ],
          );
        } else if (snapshot.hasError) {
          debugPrint("${snapshot.error}");
          return const Center(
            child: Text("Something Gone Wrong"),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ReviewHandler extends StatelessWidget {
  const ReviewHandler({
    Key? key,
    required this.name,
    // required this.profileUrl,
    required this.stars,
    required this.review,
    // required this.reviewImage,
  }) : super(key: key);
  final String name;
  // final String profileUrl;
  final int stars;
  final String review;
  // final String reviewImage;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            // Profile section
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 2, right: 4),
                child: SizedBox(
                  width: screen.width * 0.5,
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // Star section
              StarDisplayWidget(
                filledStar: const Icon(Icons.star, color: Color(0xFFF59E0B)),
                unfilledStar: const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 14,
                ),
                value: stars,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 4,
              ),
              child: Text(
                review,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          // (reviewImage != " ")
          //     ? Align(
          //         alignment: Alignment.centerLeft,
          //         child: Container(
          //           height: screen.height * 0.17,
          //           width: screen.width,
          //           decoration: BoxDecoration(
          //             borderRadius: const BorderRadius.only(
          //               topLeft: Radius.circular(10),
          //               topRight: Radius.circular(10),
          //             ),
          //             color: primaryLightColor,
          //             image: DecorationImage(
          //               image: NetworkImage("$baseUrl/" + reviewImage),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       )
          //     : Container(),
        ],
      ),
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

class RestaurantReview {
  final int id;
  final int restaurantId;
  final int rating;
  final String review;
  final String customerid;
  final String imageUrl;
  RestaurantReview(this.id, this.restaurantId, this.rating, this.review,
      this.customerid, this.imageUrl);

  RestaurantReview.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        restaurantId = json['restaurant_id'] ?? 0,
        rating = json['rating'] ?? 0,
        review = json['message'] ?? '',
        customerid = json['customer']['name'] ?? "",
        imageUrl = json['photo'] ?? "";
}

Future<List<RestaurantReview>> fetchRestaurantReviews(
    String restaurantId) async {
  final http.Response response = await http.get(Uri.parse(
      "$baseUrl/api/restaurant/slug/$restaurantId")); //TODO: Use id instead.

  if (response.statusCode == 200) {
    debugPrint("Hey###################################");
    debugPrint(response.body);
    Map result = jsonDecode(response.body);
    List<dynamic> ratingInfo = result['reviews'];
    debugPrint("############Rating info:" + ratingInfo.toString());
    return ratingInfo.map((e) => RestaurantReview.fromJson(e)).toList();
  } else {
    /// Nothing found.
    throw Exception("Something gone wrong");
  }
}
/* {
        "id": 1,
        "restaurant_id": 2,
        "customer_id": 1,
        "rating": 3,
        "message": "Hmm Not BAd Not Good",
        "photo": null,
        "created_at": "2021-08-30T04:51:43.000000Z",
        "updated_at": "2021-08-30T04:51:43.000000Z"
        }, */