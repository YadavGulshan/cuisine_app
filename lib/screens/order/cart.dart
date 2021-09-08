import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/order/checkout/checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel provider = Provider.of<CartModel>(context, listen: true);
    TextStyle titlStyle = GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    TextStyle amountStyle = TextStyle();

    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.lato(fontSize: 24),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          // Cart List
          SizedBox(
            height: screen.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  // physics: const BouncingScrollPhysics(
                  //     parent: BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: Provider.of<CartModel>(context).totalQuantity,
                  itemBuilder: (context, index) {
                    return CartContent(index: index);
                  }),
            ),
          ),

          // Total Price and Checkout Button
          Container(
            height: screen.height * 0.18,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Bill distribution.
                // Cuisine price total

                CheckoutTranscript(
                    title: "Cuisine Prize total: ",
                    amount: provider.totalPrice,
                    amountStyle: amountStyle,
                    titleStyle: titlStyle),
                // Delivery Price
                CheckoutTranscript(
                  title: "Delivery Charges",
                  amount: 69, // TODO: Use backend for fetching this
                  titleStyle: titlStyle,
                  amountStyle: amountStyle,
                ),
                // Total Price
                CheckoutTranscript(
                  title: "Total",

                  // TODO: #issue: value is not being updated in realtime
                  amount: provider.totalPrice + 69, // Fix this tooo. 69*
                  titleStyle: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  amountStyle: GoogleFonts.lato(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .removeAllItems();
                          },
                          child: const Text("Clear Cart")),

                      // Check out
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor)),
                        onPressed: () {
                          // Provider.of<CartModel>(context).();
                        },
                        child: Text(
                          "Checkout",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartContent extends StatelessWidget {
  int index;
  CartContent({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: screen.height * 0.13,
            width: screen.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    Provider.of<CartModel>(context, listen: false)
                        .items
                        .elementAt(index)
                        .imageUrl,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    Provider.of<CartModel>(context, listen: false)
                        .items[index]
                        .title
                        .toString(),
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "₹ " +
                        Provider.of<CartModel>(context, listen: false)
                            .items[index]
                            .price
                            .toString(),
                    style: GoogleFonts.lato(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),

                // Quantity section.
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryLightColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .items[index]
                                .subCuisine();
                          },
                          icon: const Icon(Icons.remove)), // remove
                      Text(Provider.of<CartModel>(context, listen: true)
                          .getItemQuantity(index.toString())
                          .toString()), // Quantity
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .items[index]
                                .addCuisine();
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
