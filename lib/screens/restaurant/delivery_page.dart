import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/services/testing/test_cuisines.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSnackBarOpen = false;
    Size screen = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Menu(
                id: CuisinesList[index]["id"].toString(),
                title: CuisinesList[index]["title"],
                price: CuisinesList[index]["price"],
                imageUrl: CuisinesList[index]["imageUrl"],
              );
            },
            childCount: CuisinesList.length,
          ),
        ),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  String id;
  String title;
  int price;
  String imageUrl;
  Menu(
      {Key? key,
      required this.id,
      required this.title,
      required this.price,
      this.imageUrl =
          "https://www.pexels.com/photo/1670977/download/?search_query=pixels&tracking_id=zd4udgyvnsg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screen.height * 0.35,
        width: screen.width * 0.45,
        decoration: BoxDecoration(
          // color: (appTheme == Brightness.light)
          //     ? primaryLightColor
          //     : Colors.grey[600],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.1, color: primaryColor),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: screen.height * 0.17,
            //   decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(10),
            //   topRight: Radius.circular(10),
            // ),
            //     image: DecorationImage(
            //       image: NetworkImage(imageUrl),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: screen.height * 0.17,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                child: Container(
                  height: screen.height * 0.17,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                baseColor: primaryColor,
                highlightColor: primaryLightColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screen.width * 0.04,
              ),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: screen.height * 0.025,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screen.height * 0.01),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screen.width * 0.04,
                    ),
                    child: Text(
                      "₹ " + price.toString(),
                      style: GoogleFonts.lato(
                        fontSize: screen.height * 0.02,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screen.width * 0.04,
                    ),
                    // Button that adds the item to the cart
                    child: InkWell(
                      onTap: () {
                        CartModel provider =
                            Provider.of<CartModel>(context, listen: false);
                        CartItem cartItem = CartItem(
                          id: id,
                          title: title,
                          price: price,
                          quantity: 1,
                          // TODO: Keep note of this.
                          imageUrl: imageUrl,
                        );

                        // Add the item to the cart

                        Provider.of<CartModel>(context, listen: false)
                            .addItem(cartItem);

                        // Print the cart
                        debugPrint(
                          "############### Item added to cart##############\nPrice: " +
                              provider.totalPrice.toString(),
                        );

                        // TODO: Remove this section, if not using
                        debugPrint(
                            "%%%%%%%%%%%%%%%%%%%%%%%%hi%%%%%%%%%%%%%%%%%%%%%%%");
                        final snackBar = SnackBar(
                          width: screen.width * 0.9,
                          duration: const Duration(seconds: 2),
                          content: Text(
                              Provider.of<CartModel>(context, listen: false)
                                  .totalPrice
                                  .toString(),
                              style: GoogleFonts.lato(
                                color: (appTheme == Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              )),
                          action: SnackBarAction(
                            label: 'checkout',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: (appTheme == Brightness.light)
                              ? primaryLightColor
                              : Colors.grey[600],
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        // (provider.totalQuantity == 0)
                        //     ? debugPrint("&&&&&&&&&&&&&&&&&&&&&&&&&&")
                        //     : ScaffoldMessenger.of(context)
                        //         .showSnackBar(snackBar);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // color: const Color(0xFF78e6fa),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          size: screen.height * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// // Not using this one for now
// Widget menu(Size screen, bool isSnackbarOpen, int id, bool isVeg, String title,
//     int price, BuildContext context, String imageUrl) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
//     child: Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(width: 0.08),
//           ),
//         ),
//         // color: Colors.green,
//         height: screen.height * 0.1,
//         width: screen.width * 0.99,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.only(bottom: 1),
//                 //   child: SvgPicture.asset(
//                 //     "assets/category.svg",
//                 //     color: (isVeg) ? Colors.greenAccent : Colors.red,
//                 //     height: screen.height * 0.026,
//                 //   ),
//                 // ),
//                 Text(
//                   title,
//                   style: GoogleFonts.lato(fontSize: 20),
//                 ),
//                 Text(
//                   "₹" + price.toString(),
//                 )
//               ],
//             ),
//             const Spacer(),
//             InkWell(
//               onTap: () {
//                 CartModel provider =
//                     Provider.of<CartModel>(context, listen: false);
//                 CartItem cartItem = CartItem(
//                   id: id.toString(),
//                   title: title,
//                   price: price.toDouble(),
//                   quantity: 1,
//                   imageUrl: imageUrl,
//                 );

//                 // Add the item to the cart
//                 Provider.of<CartModel>(context, listen: false)
//                     .addItem(cartItem);

//                 // Print the cart
//                 debugPrint(
//                   "############### Item added to cart##############\nPrice: " +
//                       provider.totalPrice.toString(),
//                 );

//                 debugPrint("%%%%%%%%%%%%%%%%%%%%%%%%hi%%%%%%%%%%%%%%%%%%%%%%%");
//                 final snackBar = SnackBar(
//                   duration: const Duration(seconds: 2),
//                   content: Text(provider.totalQuantity.toString()),
//                   action: SnackBarAction(
//                     label: 'Undo',
//                     onPressed: () {
//                       // Some code to undo the change.
//                     },
//                   ),
//                 );

//                 // Find the ScaffoldMessenger in the widget tree
//                 // and use it to show a SnackBar.
//                 (provider.totalQuantity == 0)
//                     ? debugPrint("&&&&&&&&&&&&&&&&&&&&&&&&&&")
//                     : ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: primaryColor, width: 1, style: BorderStyle.solid),
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   color: (appTheme == Brightness.light)
//                       ? primaryLightColor
//                       : Colors.blue,
//                 ),
//                 height: screen.height * 0.04,
//                 width: screen.width * 0.2,
//                 child: const Center(
//                   // child: Icon(Icons.add),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("ADD"),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         )),
//   );
// }
