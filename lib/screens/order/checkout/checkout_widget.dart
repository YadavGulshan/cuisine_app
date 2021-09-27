import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutTranscript extends StatelessWidget {
  CheckoutTranscript({
    Key? key,
    required this.title,
    required this.amount,
    required this.amountStyle,
    required this.titleStyle,
  }) : super(key: key);

  String title;
  double amount;
  TextStyle titleStyle;

  TextStyle amountStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          // Amount with rupee symbol,
          "\u20B9 $amount",
          style: amountStyle,
        ),
      ],
    );
  }
}
