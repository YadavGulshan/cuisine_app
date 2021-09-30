import 'package:cuisine_app/models/service/payment.dart';
import 'package:cuisine_app/provider/authstream1.dart';
import 'package:cuisine_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late var futurepayment;

  @override
  void initState() {
    super.initState();
    futurepayment = createPayment(
        Provider.of<AuthService>(context, listen: false).userToken,
        Provider.of<CartModel>(context, listen: false).totalPrice);
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futurepayment,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/checkout_confirmed.json",
                    height: MediaQuery.of(context).size.height * 0.4,
                    controller: _controller,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Text(
                  "Your order is Processed.",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Checkout failed!"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
