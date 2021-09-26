import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  // This cart will reset after user changes the screen, from one restaurant to another.
  // Store id and price of the product
  List<CartItem> _items = [];

  // Getter
  List<CartItem> get items => _items;

  // Add item to cart
  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  // Remove all items from cart
  void removeAllItems() {
    _items.clear();
    notifyListeners();
  }

  // Get total price of all items in cart
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }

  // Get total quantity of all items in cart
  int get totalQuantity {
    int total = 0;
    for (var item in _items) {
      total += item.quantity;
    }
    return total;
  }

  // Get the quantity of a specific item
  int getItemQuantity(String id) {
    int quantity = 0;
    for (var item in _items) {
      if (item.id == id) {
        quantity = item.quantity;
      }
    }
    return quantity;
  }
}

class CartItem extends ChangeNotifier {
  final String id;
  final String title;
  int quantity;
  final int price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  void addCuisine() {
    quantity += 1;
    notifyListeners();
  }

  void subCuisine() {
    quantity -= 1;
    notifyListeners();
  }
}
