import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SearchBar(
        hinttext: "Search",
      ),
    ));
  }
}
