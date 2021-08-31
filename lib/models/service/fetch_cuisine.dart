import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cuisine_app/constants.dart';

fetchCuisine(double restaurantId) async {
  http.Response response =
      await http.get(Uri.parse("$baseUrl/restaurant/$restaurantId"));
  if (response.statusCode == 200) {
    Map cuisineData = jsonDecode(response.body);
    List<dynamic> cuisine = cuisineData["cuisines"];

    return cuisine.map((json) => CuisineModel.fromJson(json)).toList();
  } else {
    throw Exception("Something gone wrong ${response.statusCode}");
  }
}
