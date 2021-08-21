import 'package:flutter/material.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.2;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?crop=entropy&cs=srgb&dl=pexels-pixabay-315755.jpg&fit=crop&fm=jpg&h=960&w=640"),
                radius: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
