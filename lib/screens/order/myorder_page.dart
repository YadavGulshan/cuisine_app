import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Orders",
                style: TextStyle(fontSize: 32),
              ),
              OrderTiles(
                title: "Burger Pizza",
                price: 230,
                orderId: "12345",
                date: "12/12/2020",
              ),
              OrderTiles(
                title: "Chinese",
                price: 500,
                orderId: "5627",
                date: "12/11/2021",
              ),
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
                        "ID: " + orderId,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "₹" + price.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
