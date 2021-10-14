import 'dart:convert';

import 'package:cuisine_app/provider/authstream1.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/order/checkout_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants.dart';

class Payment extends ChangeNotifier {
  int paymentId;
  Payment(this.paymentId);

  Payment.fromJson(Map<String, dynamic> json) : paymentId = json['id'];

  get accessId => paymentId;
}

Future<Payment> createPayment(
  String accessToken,
  double amount,
  String restaurantId,
  item,
  BuildContext context,
) async {
  debugPrint("Access Token: " + accessToken.toString());
  http.Response response = await http.post(
    Uri.parse("$baseUrl/api/payment"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, String>{
      'amount': amount.toString(),
    }),
  );
  debugPrint("Response status code: " + response.statusCode.toString());
  if (response.statusCode == 201) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CheckoutPage()));

    return Payment.fromJson(jsonDecode(response.body));
  } else {
    SnackBar snackBar = const SnackBar(
      content: Text("Something gone wrong"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception("Failed to create payment");
  }
}

/// Placing the order.

class OrderConfirmation {
  String paymentId;
  String restraunt;
  String destinition;
  String total;

  OrderConfirmation(
    this.paymentId,
    this.restraunt,
    this.destinition,
    this.total,
  );

  OrderConfirmation.fromJson(Map<String, dynamic> json)
      : paymentId = json['payment_id'],
        restraunt = json['restaurant'],
        total = json['total'],
        destinition = json['destinition'];
}

Future<OrderConfirmation> completePayment(
  String accessToken,
  int paymentId,
  double total,
  String restaurantid,
  String address,
  List<Map<String, int>> items,
  context,
) async {
  http.Response response =
      await http.post(Uri.parse("$baseUrl/api/order"), headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    'Authorization': 'Bearer $accessToken',
  }, body: {
    'total': total.toString(),
    'restaurant': restaurantid,
    'destination': address,
    'payment_id': paymentId,
    'items': items,
  });

  debugPrint("Response status code: " + response.statusCode.toString());

  if (response.statusCode == 201) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CheckoutPage()));

    return OrderConfirmation.fromJson(jsonDecode(response.body));
  } else {
    debugPrint(
        "Order Confirmation Status Code: " + response.statusCode.toString());

    SnackBar snackBar = const SnackBar(
      content: Text("Something gone wrong"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception("Failed to confirm Order");
  }
}
