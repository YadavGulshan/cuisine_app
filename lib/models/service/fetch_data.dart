import 'dart:convert';

import 'package:cuisine_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

Future<List<RestaurantModel>> fetchData() async {
  http.Response response =
      await http.get(Uri.parse("http://127.0.0.1:8000/api/restaurants"));
  if (response.statusCode == 200) {
    Map restaurantData = jsonDecode(response.body);
    List<dynamic> restaurant = restaurantData["data"];
    // Return the the json with our model.
    return restaurant.map((json) => RestaurantModel.fromJson(json)).toList();
  } else {
    throw Exception("Something gone wrong ${response.statusCode}");
  }
}
