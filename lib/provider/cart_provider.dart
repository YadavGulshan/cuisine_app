// import 'package:flutter/cupertino.dart';

// class CartModel extends ChangeNotifier {
//   // Store the items in cart with id and quantity
//   Map<String, int> _items = {};

//   Map<String, int> get items {
//     return {..._items};
//   }

//   int get itemCount {
//     return _items.length;
//   }

//   double get totalAmount {
//     double total = 0.0;
//     _items.forEach((key, value) {
//       total += value * _items[key]!.toDouble();
//     });
//     return total;
//   }

//   void addItem(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.update(productId, (value) => value + 1);

//       // Update the cart
//       notifyListeners();
//     } else {
//       _items.putIfAbsent(productId, () => 1);
//       // Update the cart
//       notifyListeners();
//     }
//   }

//   void removeItem(String productId) {
//     if (_items.containsKey(productId)) {
//       if (_items[productId] == 1) {
//         _items.remove(productId);
//       } else {
//         _items.update(productId, (value) => value - 1);
//       }
//       // Update the cart
//       notifyListeners();
//     }
//   }

//   void removeSingleItem(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.remove(productId);
//       // Update the cart
//       notifyListeners();
//     }
//   }

//   void clear() {
//     _items = {};
//     notifyListeners();
//   }

//   void removeItemFromCart(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void addSingleItem(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.update(productId, (value) => value + 1);
//       // Update the cart
//       notifyListeners();
//     } else {
//       _items.putIfAbsent(productId, () => 1);
//       // Update the cart
//       notifyListeners();
//     }
//   }

//   void removeSingleItemFromCart(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.update(productId, (value) => value - 1);
//       // Update the cart
//       notifyListeners();
//     }
//   }

//   void updateItemQuantity(String productId, int quantity) {
//     if (quantity > 0) {
//       _items.update(productId, (value) => quantity);
//       notifyListeners();
//     } else {
//       removeItemFromCart(productId);
//     }
//   }
// }

// class CartItem {
//   final String id;
//   final String title;
//   final int quantity;
//   final double price;
//   final String imageUrl;

//   CartItem(this.id, this.title, this.quantity, this.price, this.imageUrl);
// }

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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

  // void addCuisine() {
  //   quantity++;
  //   notifyListeners();
  // }

  // void subCuisine() {
  //   quantity -= 1;
  //   notifyListeners();
  // }
}
