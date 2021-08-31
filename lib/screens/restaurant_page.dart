import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  String title;
  String address;
  double rating;
  int restaurantId;
  RestaurantPage({
    Key? key,
    required this.restaurantId,
    required this.title,
    required this.address,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
