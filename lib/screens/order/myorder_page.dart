import 'dart:convert';

import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/provider/authstream.dart';
import 'package:cuisine_app/provider/authstream1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late Future<List<PreviousOrders>> futureOrders;
  @override
  void initState() {
    super.initState();
    futureOrders = fetchPreviousOrder(
        Provider.of<AuthService>(context, listen: false).userId,
        Provider.of<AuthService>(context, listen: false).userToken,
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Orders",
                style: TextStyle(fontSize: 32),
              ),
              FutureBuilder(
                  future: futureOrders,
                  builder:
                      (context, AsyncSnapshot<List<PreviousOrders>> snapshot) {
                    if (snapshot.hasData) {
                      debugPrint(snapshot.data.toString());
                      if (snapshot.data!.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, int index) {
                              var order = snapshot.data![index];
                              return OrderTiles(
                                title: order.title,
                                orderId: order.orderId,
                                price: order.price,
                                date: order.date,
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("No order found"),
                        );
                      }
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something Gone Wrong"),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTiles extends StatelessWidget {
  final String title;
  final String orderId;
  final int price;
  final String date;
  const OrderTiles({
    Key? key,
    required this.title,
    required this.orderId,
    required this.price,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Container(
        height: size.height * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.5,
                        // color: Colors.red,
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 24),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "ID: #" + orderId,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      child: Text(
                        "₹" + price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width * 0.35,
                      child: Text(
                        date,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

/// Getting previous orders
class PreviousOrders {
  final String title;
  final String orderId;
  final int price;
  final String date;

  PreviousOrders(
      {required this.title,
      required this.orderId,
      required this.price,
      required this.date});

  PreviousOrders.fromJson(Map<String, dynamic> json)
      : title = json['name'],
        orderId = json['order_id'].toString(),
        price = json['price'],
        date = json['created_at'];
}

Future<List<PreviousOrders>> fetchPreviousOrder(
    int id, String token, BuildContext context) async {
  debugPrint("################fetching");
  debugPrint("Token: $token, id: $id");
  final response = await http.get(
    Uri.parse(
      "$baseUrl/api/order/$id",
    ),
    headers: {
      "Accept": 'application/json',
      "User-Agent": 'Flutter 2.6',
      "Authorization": 'Bearer $token',
    },
  );
  debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    debugPrint("## Response: " + response.toString());
    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      List<dynamic> data = result['items'];
      return data.map((e) => PreviousOrders.fromJson(e)).toList();
    }
    throw Exception("No data found");
  } else {
    throw Exception(
      "Something Gone Wrong. Status Code: ${response.statusCode}",
    );
  }
}
