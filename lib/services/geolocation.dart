import 'dart:convert';

import 'package:cuisine_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  LocationServiceState createState() => LocationServiceState();
}

class LocationServiceState extends State<LocationService> {
  double longitude = 0.0;
  double latitude = 0.0;
  String address = '';
  void getCurrenLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      // Service is disabled.
      await Geolocator.openLocationSettings();

      // Check again to see if the user enabled the service.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // If still service is disabled, show an error message.
      // if (!serviceEnabled) {
      //   return 403;
      // }
    }

    // Check if the location service is enabled.
    if (permission == LocationPermission.denied) {
      // Ask for permission again.
      permission = await Geolocator.requestPermission();

      // If permission is denied, return 403
      // if (permission == LocationPermission.denied) {
      //   return 403;
      // }
    }

    // Get location
    var postition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    List<Placemark> newPlace =
        await placemarkFromCoordinates(postition.latitude, postition.longitude);

    Placemark placemark = newPlace[1];
    debugPrint("########Placemark: " + placemark.toString());
    // Set the lon and lat
    setState(() {
      latitude = postition.latitude;
      longitude = postition.longitude;
      address =
          "${placemark.name.toString()}, ${placemark.subLocality.toString()}";
    });

    // return 200;
  }

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Homepage(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      address: address,
    );
  }
}
