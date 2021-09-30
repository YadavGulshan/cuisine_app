import 'dart:convert';
import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/models/service/payment.dart';
import 'package:cuisine_app/provider/authstream1.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/screens/order/checkout/checkout_widget.dart';
import 'package:cuisine_app/screens/order/checkout_page.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:cuisine_app/user.dart';
import 'package:cuisine_app/widgets/cart_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel provider = Provider.of<CartModel>(context, listen: true);
    TextStyle titlStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    TextStyle amountStyle = const TextStyle();

    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: screen.height * 0.2,
              color: Theme.of(context).primaryColorLight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Shipping address"),
                      TextButton(
                        onPressed: () {},
                        child: const Text("edit"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.place,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // color: Colors.amber,
                            width: screen.width * 0.7,
                            child: Text(
                              Provider.of<AuthService>(context, listen: false)
                                  .userName,
                              // "test1@test.com",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: SizedBox(
                              // color: Colors.amber,
                              width: screen.width * 0.7,
                              child: Text(
                                Provider.of<AuthService>(context, listen: false)
                                    .userEmail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                // "test1@test.com",
                              ),
                            ),
                          ),
                          SizedBox(
                            // color: Colors.amber,
                            width: screen.width * 0.7,
                            child: Text(
                              Provider.of<CurrentLocation>(context,
                                      listen: false)
                                  .addressStatus,
                              // "Unamed road, Patlipada",
                              style: const TextStyle(fontSize: 14),
                              maxLines: 10,
                            ),
                          ),
                          // Row(
                          //   children: [Text("Thane West"), Text("400607")],
                          // ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // Cart List
          SizedBox(
            height: screen.height * 0.45,
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
                  amount: 0, // TODO: Use backend for fetching this
                  titleStyle: titlStyle,
                  amountStyle: amountStyle,
                ),
                // Total Price
                CheckoutTranscript(
                  title: "Total",

                  // TODO: #issue: value is not being updated in realtime
                  amount: provider.totalPrice + 0, // Fix this tooo. 69*
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  amountStyle: TextStyle(),
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
                          // Provider.of<CartModel>(context).()
                          // if cart is empty then do not allow checkout
                          if (Provider.of<CartModel>(context, listen: false)
                                  .totalQuantity !=
                              0) {
                            createPayment(
                              Provider.of<AuthService>(context, listen: false)
                                  .userToken,
                              Provider.of<CartModel>(context, listen: false)
                                  .totalPrice,
                              context,
                            );
                          } else {
                            SnackBar snackBar = const SnackBar(
                              content: Text("Please add something in cart"),
                              backgroundColor: Colors.blue,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
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
