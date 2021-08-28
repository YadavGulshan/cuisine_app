import 'package:flutter/material.dart';

Future<dynamic> bottomSheet(BuildContext context, double height) {
  return showModalBottomSheet(
      // backgroundColor: Colors.red,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: height * 0.7,
          // child: TextButton(
          //   child: const Text("WORK IN PROGRESS"),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        );
      });
}
