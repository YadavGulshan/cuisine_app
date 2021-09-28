// import 'dart:convert';

// import 'package:cuisine_app/constants.dart';
// import 'package:cuisine_app/models/restaurant_model.dart';
// import 'package:http/http.dart' as http;

// Future<List<RestaurantModel>> fetchData() async {
//   http.Response response = await http.get(Uri.parse("$baseUrl/restaurants"));
//   if (response.statusCode == 200) {
//     Map restaurantData = jsonDecode(response.body);
//     List<dynamic> restaurant = restaurantData["data"];
//     // Return the the json with our model.
//     return restaurant.map((json) => RestaurantModel.fromJson(json)).toList();
//   } else {
//     throw Exception("Something gone wrong ${response.statusCode}");
//   }
// }
