import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextFormField(
                      enabled: true,
                      autofocus: true,
                      // cursorHeight: 25,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        enabled: true,
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(),
      ],
    ));
  }
}
