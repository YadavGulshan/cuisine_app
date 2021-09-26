import 'package:cuisine_app/screens/user/search_result.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatelessWidget {
  bool searchIcon;
  double iconSize;
  String hinttext;
  bool autofocus;
  EdgeInsetsGeometry edgeInsetsGeometry;
  double blurRadius;
  TextEditingController mycontroller = TextEditingController();

  /// Form key
  final _SearchformKey = GlobalKey<FormState>();
  SearchBar({
    Key? key,
    this.searchIcon = false,
    this.iconSize = 20,
    this.autofocus = true,
    this.blurRadius = 0.4,
    this.edgeInsetsGeometry = const EdgeInsets.all(18.0),
    required this.hinttext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.062;
    return Padding(
      padding: edgeInsetsGeometry,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
          boxShadow: [
            BoxShadow(blurRadius: blurRadius),
          ],
        ),
        height: height,
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
              child: Form(
                key: _SearchformKey,
                child: TextFormField(
                  controller: mycontroller,
                  enabled: true,
                  autofocus: autofocus,
                  onFieldSubmitted: (val) {
                    debugPrint("Submitted");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchResultPage(
                          query: val,
                        ),
                      ),
                    );
                  },
                  // cursorHeight: 25,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    enabled: true,
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    hintText: hinttext,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
