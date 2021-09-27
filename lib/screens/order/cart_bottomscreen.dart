import 'package:cuisine_app/constants.dart';
import 'package:cuisine_app/services/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> cartBottomSheet(
  BuildContext context,
  int restaurantId,
  int id,
  String title,
  int quantity,
  double price,
  String imageUrl,
) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(10.0),
      ),
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Size screen = MediaQuery.of(context).size;
        return SizedBox(
          height: screen.height * 0.7,
          child: Column(
            children: [
              // Deliver at
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.place),
                      SizedBox(
                        width: screen.width * 0.8,
                        child: const Text(
                          // TODO: Location.
                          // Provider.of<CurrentLocation>(context, listen: false)
                          //     .addressStatus,
                          "Pariatu Cillum reprehenderit et adipisicing adipisicing reprehenderit veniam nulla pariatur qui velit est magna amet ipsum. Adipisicing cillum eiusmod enim nisi minim Lorem culpa in anim incididunt eiusmod labore esse. Officia esse ipsum veniam mollit ipsum ullamco consequat magna aliquip. Mollit magna ex ad exercitation enim.",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              ),
              // Expected delivery time
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.schedule),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screen.width * 0.01,
                      ),
                      child: SizedBox(
                        width: screen.width * 0.8,
                        child: const Text(
                          // TODO: deliver in
                          // Provider.of<CurrentLocation>(context, listen: false)
                          //     .addressStatus,
                          "Delivery in 69 mins",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Cuisine list
            ],
          ),
        );
      });
}
