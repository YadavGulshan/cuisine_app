import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class Payment {
  String paymentId;
  Payment(this.paymentId);

  Payment.fromJson(Map<String, dynamic> json) : paymentId = json['id'];
}

Future<Payment> createPayment(String accessToken, double amount) async {
  http.Response response = await http.post(
    Uri.parse("$baseUrl/api/payment"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, String>{
      'address': amount.toString(),
    }),
  );
  if (response.statusCode == 200) {
    return Payment.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to create payment");
  }
}

/// Placing the order.

// class OrderConfirmation{
//   String paymentId;
//   String restraunt;
//   String destinition;
//   String total;
//   String items;

// }

// Future
