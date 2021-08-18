import 'package:flutter/material.dart';

Future<dynamic> bottomSheet(BuildContext context, double height) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: height / 1.5,
          child: TextButton(
            child: const Text("WORK IN PROGRESS"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      });
}
