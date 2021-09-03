import 'dart:ui';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSnackBarOpen = false;
    Size screen = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Pan Cake",
                60,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Pizza",
                0,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Burger",
                200,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "French Fries",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
              menu(
                screen,
                isSnackBarOpen,
                1,
                true,
                "Grilled Pan",
                50,
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget menu(Size screen, bool isSnackbarOpen, int id, bool isVeg, String title,
    int price, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
    child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.08))),
        // color: Colors.green,
        height: screen.height * 0.1,
        width: screen.width * 0.99,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 1),
                //   child: SvgPicture.asset(
                //     "assets/category.svg",
                //     color: (isVeg) ? Colors.greenAccent : Colors.red,
                //     height: screen.height * 0.026,
                //   ),
                // ),
                Text(
                  title,
                  style: GoogleFonts.lato(fontSize: 20),
                ),
                Text(
                  "₹" + price.toString(),
                )
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                CartModel provider =
                    Provider.of<CartModel>(context, listen: false);
                CartItem cartItem = CartItem(
                    id: 1, title: title, price: price.toDouble(), quantity: 1);

                // Add the item to the cart
                Provider.of<CartModel>(context, listen: false)
                    .addItem(cartItem);

                // Print the cart
                debugPrint(
                  "############### Item added to cart##############\nPrice: " +
                      provider.totalPrice.toString(),
                );

                debugPrint("%%%%%%%%%%%%%%%%%%%%%%%%hi%%%%%%%%%%%%%%%%%%%%%%%");
                final snackBar = SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(provider.totalQuantity.toString()),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                (provider.totalQuantity == 0)
                    ? debugPrint("&&&&&&&&&&&&&&&&&&&&&&&&&&")
                    : ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryColor, width: 1, style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: (appTheme == Brightness.light)
                      ? primaryLightColor
                      : Colors.blue,
                ),
                height: screen.height * 0.04,
                width: screen.width * 0.2,
                child: const Center(
                  // child: Icon(Icons.add),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("ADD"),
                  ),
                ),
              ),
            )
          ],
        )),
  );
}
