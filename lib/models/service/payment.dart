import 'dart:convert';

import 'package:cuisine_app/screens/order/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class Payment {
  int paymentId;
  Payment(this.paymentId);

  Payment.fromJson(Map<String, dynamic> json) : paymentId = json['id'];
}

Future<Payment> createPayment(
    String accessToken, double amount, BuildContext context) async {
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

// class OrderConfirmation {
//   String paymentId;
//   String restraunt;
//   String destinition;
//   String total;
//   String items;

//   OrderConfirmation(
//       this.paymentId, this.restraunt, this.destinition, this.total, this.items);
// }

// Future<OrderConfirmation> completePayment(String token, String total, String restaurantid, String )async{

// }
