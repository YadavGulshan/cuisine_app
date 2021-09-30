import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartContent extends StatelessWidget {
  final int index;
  const CartContent({
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
            height: screen.height * 0.10,
            width: screen.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    // Provider.of<CartModel>(context, listen: false)
                    //     .items
                    //     .elementAt(index)
                    //     .imageUrl,
                    context.watch<CartModel>().items.elementAt(index).imageUrl,
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
                  child: SizedBox(
                    width: screen.width * 0.5,
                    child: Text(
                      Provider.of<CartModel>(context, listen: false)
                          .items[index]
                          .title
                          .toString(),
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "₹ ${context.watch<CartModel>().items[index].price}",
                    // Provider.of<CartModel>(context, listen: false)
                    //     .items[index]
                    //     .price
                    //     .toString(),
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),

                // Quantity section.
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Provider.of<CartModel>(context, listen: false)
                            //     .items[index]
                            //     .quantity--;
                            context.read<CartModel>().items[index].quantity--;
                          },
                          icon: const Icon(Icons.remove)), // remove
                      // Text(Provider.of<CartModel>(context, listen: true)
                      //     .getItemQuantity(index.toString())
                      //     .toString()),
                      //
                      Text(
                          "${context.watch<CartModel>().items[index].quantity}"),

                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            // Provider.of<CartModel>(context, listen: false)
                            //     .items[index]
                            //     .quantity++;
                            context.read<CartModel>().items[index].quantity++;
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
