import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  LocationServiceState createState() => LocationServiceState();
}

class LocationServiceState extends State<LocationService> {
  final longitude = "";
  final latitude = "";
  Future getCurrenLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      // Checking again if user grants the permission
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return Future.error("User location service is not enabled");
      }
    }
    if (permission == LocationPermission.denied) {
      // Ask for permission
      permission = await Geolocator.requestPermission();
    } else {
      // Throw another method to user. i.e. provide location manually.
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
    // Get location
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
