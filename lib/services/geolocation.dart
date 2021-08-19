import 'package:cuisine_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  LocationServiceState createState() => LocationServiceState();
}

class LocationServiceState extends State<LocationService> {
  double longitude = 0.0;
  double latitude = 0.0;
  var address;
  var statusCode;
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

    // Set the lon and lat
    setState(() {
      longitude = postition.longitude;
      latitude = postition.latitude;
      final coordinates = Coordinates(longitude, latitude);
      address = Geocoder.local.findAddressesFromCoordinates(coordinates);
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
      address: address.toString(),
    );
  }
}
