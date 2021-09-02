import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        // Profile section
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(testUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: const [
                                Text("Gulshan Yadav"),
                                StarDisplayWidget(
                                  filledStar:
                                      Icon(Icons.star, color: Colors.yellow),
                                  unfilledStar: Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  value: 2,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;

  const StarDisplayWidget({
    Key? key,
    this.value = 0,
    required this.filledStar,
    required this.unfilledStar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}
