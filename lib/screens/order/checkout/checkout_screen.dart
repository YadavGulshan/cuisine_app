import 'package:cuisine_app/provider/infoprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Info provider = Provider.of<Info>(context);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Deliver to:",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              // checkoutRow("Address", provider.getaddress, context),
              // checkoutRow("City", provider.getcity, context),
              // checkoutRow("State", provider.getstate, context),
              // checkoutRow("Zip", provider.getzip.toString(), context),
              // checkoutRow("Phone", provider.getphone.toString(), context),
              checkoutRow(
                  "Address",
                  "Nulla commodo Lorem culpa excepteur incididunt dolor nulla tempor pariatur ut.",
                  context),
              checkoutRow("City", "Thane", context),
              checkoutRow("State", "Maharashtra", context),
              checkoutRow("Zip", "400607", context),
              checkoutRow("Phone", "5662232665", context),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                ),
                child: TextButton(
                    onPressed: () {}, child: const Text("Change Address")),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget checkoutRow(String title, String value, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          // color: Colors.amber,
          child: Text(
            "$title: ",
            textAlign: TextAlign.end,
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        // Text(value, style: Theme.of(context).textTheme.headline5),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              value,
              // "Voluptate deserunt et dolor minim veniam do officia exercitation.",
              maxLines: 10,
              style: GoogleFonts.lato(fontSize: 20, color: Colors.grey[700]),
            ),
          ),
        ),
      ],
    ),
  );
}
