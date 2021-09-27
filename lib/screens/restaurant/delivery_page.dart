import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:cuisine_app/services/testing/test_cuisines.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class DeliveryPage extends StatefulWidget {
  String restaurantid;
  DeliveryPage({
    Key? key,
    required this.restaurantid,
  }) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  late Future<List<RestaurantCuisines>> futureCuisine =
      fetchCuisine(widget.restaurantid);

  @override
  void initState() {
    super.initState();
    futureCuisine = fetchCuisine(widget.restaurantid);
    debugPrint("##############Future cuisine: " + futureCuisine.toString());
  }

  @override
  Widget build(BuildContext context) {
    var cuisinegrid;
    bool isSnackBarOpen = false;
    Size screen = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureCuisine,
      builder: (context, AsyncSnapshot<List<RestaurantCuisines>> snapshot) {
        debugPrint("###########Snapshot: " + snapshot.toString());
        if (snapshot.hasData) {
          debugPrint("###########Snapshot has data: " +
              snapshot.data![0].name.toString());
          cuisinegrid = SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // var currentCuisine = snapshot.data![index];
                return Menu(
                  id: snapshot.data![index].id.toString(),
                  title: snapshot.data![index].name,
                  price: snapshot.data![index].price,
                  imageUrl: "$baseUrl/" + snapshot.data![index].imageUrl,
                );
              },
              childCount: snapshot.data?.length,
            ),
          );
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              cuisinegrid,
            ],
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.toString());
          return const Center(
            child: Text("Something Gone Wrong"),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
        height: screen.height * 0.4,
        width: screen.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.1, color: primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: screen.height * 0.15,
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
                baseColor: Theme.of(context).primaryColor,
                highlightColor: Theme.of(context).primaryColorLight,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screen.width * 0.04,
              ),
              child: Text(
                title,
                style: TextStyle(
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
                      style: TextStyle(
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
//                   style: TextStyle(fontSize: 20),
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
class RestaurantCuisines {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final int restaurantid;

  RestaurantCuisines(
      this.id, this.name, this.price, this.imageUrl, this.restaurantid);

  RestaurantCuisines.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? "",
        imageUrl = json['image'] ?? "",
        price = json['price'] ?? 0,
        restaurantid = json['restaurant_id'] ?? 0;
}

Future<List<RestaurantCuisines>> fetchCuisine(String id) async {
  final http.Response response = await http.get(
      Uri.parse("$baseUrl/api/restaurant/slug/$id")); //TODO: Use id instead.

  if (response.statusCode == 200) {
    debugPrint("Hey###################################");
    debugPrint(response.body);
    Map result = jsonDecode(response.body);
    List<dynamic> cuisineInfo = result['cuisines'];
    debugPrint("Cuisine Info: " + cuisineInfo.toString());
    return cuisineInfo.map((e) => RestaurantCuisines.fromJson(e)).toList();
  } else {
    /// Nothing found.
    throw Exception("Something gone wrong");
  }
}


/*
 {
        "id": 1,
        "name": "Chilly Noodles",
        "price": 400,
        "image": "storage/images/cuisines/chilly-noodles.jpg",
        "isPublished": 1,
        "restaurant_id": 2,
        "created_at": "2021-08-30T04:51:37.000000Z",
        "updated_at": "2021-08-30T04:51:37.000000Z"
        },
        */