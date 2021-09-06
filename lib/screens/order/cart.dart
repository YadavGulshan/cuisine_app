import 'dart:ui';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.lato(fontSize: 24),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primaryLightColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.place),
                    SizedBox(
                      width: screen.width * 0.7,
                      child: const Text(
                        // TODO: Location.
                        // Provider.of<CurrentLocation>(context, listen: false)
                        //     .addressStatus,
                        "Pariatu Cillum reprehenderit et adipisicing adipisicing reprehenderit veniam nulla pariatur qui velit est magna amet ipsum. Adipisicing cillum eiusmod enim nisi minim Lorem culpa in anim incididunt eiusmod labore esse. Officia esse ipsum veniam mollit ipsum ullamco consequat magna aliquip. Mollit magna ex ad exercitation enim.",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ),
              CartContent(index: 0)
            ],
          ),
        ),
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
                          .items[index]
                          .imageUrl
                          .toString()),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  Provider.of<CartModel>(context, listen: false)
                      .items[index]
                      .title
                      .toString(),
                  style: GoogleFonts.lato(fontSize: 20),
                ),
                Text(
                  "₹ " +
                      Provider.of<CartModel>(context, listen: false)
                          .items[index]
                          .price
                          .toString(),
                  style: GoogleFonts.lato(fontSize: 14),
                  textAlign: TextAlign.left,
                ),

                // Quantity section.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .items[index]
                              .subCuisine();
                        },
                        icon: const Icon(Icons.remove)), // remove
                    Container(
                        // child: Text(Provider.of<CartModel>(context, listen: true)
                        //     .cuisineQuantity
                        //     .toString()),
                        ), // Quantity
                    IconButton(
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .items[index]
                              .addCuisine();
                        },
                        icon: const Icon(Icons.add)), // Add
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
