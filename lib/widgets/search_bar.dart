import 'package:flutter/material.dart';

import '../constants.dart';

class SearchBar extends StatelessWidget {
  bool searchIcon;
  double iconSize;
  String hinttext;
  SearchBar({
    Key? key,
    this.searchIcon = false,
    this.iconSize = 20,
    required this.hinttext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor),
            color: (appTheme == Brightness.light)
                ? Colors.white
                : Colors.grey[800],
            boxShadow: const [BoxShadow(blurRadius: 0.4)]),
        height: MediaQuery.of(context).size.height * 0.062,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                if (!searchIcon) {
                  // Not a search Icon, means a back button
                  Navigator.pop(context);
                }
              },

              // If we want search Icon insead of back icon, then searchIcon var should be true.
              icon: (searchIcon)
                  ? Icon(
                      Icons.search,
                      size: iconSize,
                    )
                  : Icon(
                      Icons.arrow_back_ios,
                      size: iconSize,
                    ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: TextFormField(
                enabled: true,
                autofocus: true,
                // cursorHeight: 25,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  enabled: true,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: hinttext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
