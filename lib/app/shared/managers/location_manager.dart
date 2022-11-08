import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  static Future<Position> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')));
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Location permission are permanently denied, kindly enable location permissions in your settings',
        )),
      );
      return Future.error(
          'Location permission are permanently denied, kindly enable location permissions in your settings');
    }
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  setLocationName(BuildContext context) async {
    Position position = await LocationManager.getCurrentLocation(context);
    final lat = position.latitude;
    final lng = position.longitude;
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);

    final address1 = placeMarks[0].name;
    final address2 = placeMarks[0].locality;
    final address3 = placeMarks[0].country;

    final userAddressValue = '${address1.toString()}, ${address2.toString()}';
    print(userAddressValue);
    return userAddressValue;
  }
}
