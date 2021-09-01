import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  // This cart will reset after user changes the screen, from one restaurant to another.
  late List<Map<int, int>> cartContent; // id and quantity

}
