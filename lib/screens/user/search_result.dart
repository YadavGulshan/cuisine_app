import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchResultPage extends StatefulWidget {
  String query;
  SearchResultPage({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late Future<List<SearchResult>> _searchResult;
  @override
  void initState() {
    super.initState();
    _searchResult = fetchQuery(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                    text: "Search result for ",
                    style: Theme.of(context).textTheme.headline5,
                    children: [
                      TextSpan(
                        text: '"${widget.query}"',
                        style: GoogleFonts.lato(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      )
                    ]),
              ),
            ),
            FutureBuilder(
              future: _searchResult,
              builder: (BuildContext context,
                  AsyncSnapshot<List<SearchResult>> snapshot) {
                if (snapshot.hasData) {
                  // debugPrint(
                  //     "COnnection state: " + ConnectionState.done.toString());
                  debugPrint("length: " + snapshot.data!.length.toString());
                  // debugPrint(snapshot.data?[0].name.toString());
                  return (snapshot.data!.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var currentRestaurant = snapshot.data![index];
                                debugPrint("index: " + index.toString());
                                debugPrint(snapshot.data![index].name);
                                return RestaurantWidget(
                                  title: currentRestaurant.name,
                                  imageUrl:
                                      "$baseUrl/" + currentRestaurant.imageUrl,
                                  category: currentRestaurant.category,
                                  rating: currentRestaurant.rating,
                                  address: currentRestaurant.address,
                                  slug: currentRestaurant.slug,
                                  id: currentRestaurant.id.toString(),
                                  showRating: false,
                                );
                                // return Center(
                                //   child: Text(currentRestaurant.name),
                                // );
                              }),
                        )
                      : Center(
                          child: Text(
                            "No results found",
                            style: GoogleFonts.inter(fontSize: 20),
                          ),
                        );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Image.asset("assets/somethinggonewrong.png"),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}

/// Now fetch the information from web.
/// Parse it.

Future<List<SearchResult>> fetchQuery(String query) async {
  final http.Response response =
      await http.get(Uri.parse("$baseUrl/api/restaurant/search/$query"));

  if (response.statusCode == 200) {
    List result = jsonDecode(response.body);
    // List<dynamic> restaurantInfo = result['data'];
    return result.map((e) => SearchResult.fromJson(e)).toList();
  } else {
    /// Nothing found.
    throw Exception("Nothing found.");
  }
}

class SearchResult {
  final int id;
  final String name;
  final String imageUrl;
  final String address;
  final String category;
  final String rating;
  final String slug;

  SearchResult({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.category,
    required this.rating,
    required this.slug,
  });

  // SearchResult.fromJson(Map<String, dynamic> json) {
  //   debugPrint(json.toString());
  //   debugPrint(json['id'].toString());
  //   return SearchResult(
  //     id: json['id'],
  //     name: json['name'],
  //     imageUrl: json['photo'],
  //     address: json['address'],
  //     category: json['slug'],
  //     // rating: json['data'][],
  //   );
  // }

  SearchResult.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        imageUrl = json['photo'],
        address = json['address'],
        category = json['category'].cast<String>().join(', '),
        rating = json['reviews_avg_rating'],
        slug = json['slug'];
}

// {
//       "id": 2,
//       "name": "Restaurant One",
//       "slug": "restaurant-one",
//       "photo": "storage/images/restaurants/restaurant_one.jpg",
//       "phone": "9876543210",
//       "email": "restaurant.one@domain.com",
//       "owner": "The One Man",
//       "isBanned": 0,
//       "address": "123st, hello ,world",
//       "city": "hello",
//       "state": "world",
//       "zip": 654321,
//       "latitude": null,
//       "longitude": null,
//       "isAdmin": 0,
//       "created_at": "2021-09-26T03:49:30.000000Z",
//       "updated_at": "2021-09-26T03:49:30.000000Z"
// }
