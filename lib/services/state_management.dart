import 'package:flutter/material.dart';

class Cuisine extends ChangeNotifier {
  // A cuisine will have a id and a name with id of a restaurant
  int id;
  String name;
  int restaurantId;
  int price;

  Cuisine({
    required this.id,
    required this.name,
    required this.restaurantId,
    required this.price,
  });

  @override
  Future<void> notifyListeners() async {
    super.notifyListeners();
  }

  void setId(int id) {
    this.id = id;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setRestaurantId(int restaurantId) {
    this.restaurantId = restaurantId;
    notifyListeners();
  }

  void setPrice(int price) {
    this.price = price;
    notifyListeners();
  }
}
