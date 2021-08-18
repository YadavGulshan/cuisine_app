import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  LocationServiceState createState() => LocationServiceState();
}

class LocationServiceState extends State<LocationService> {
  var locationDetail = "";

  Future getCurrenLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Get user location

    }
    if (permission == LocationPermission.denied) {
      // Ask for permission and then recall this function.
      permission = await Geolocator.requestPermission();
      getCurrenLocation();
    } else {
      // Throw another method to user. i.e. provide location manually.
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
