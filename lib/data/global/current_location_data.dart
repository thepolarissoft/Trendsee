import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class CurrentLocationData {
  LatLng latlong;
  CameraPosition cameraPosition;

  void getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      print("statuses-> $statuses");
      // ignore: unrelated_type_equality_checks
      if (statuses == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        getLocation(context);
      }
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("serviceEnabled-> $serviceEnabled");
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // permission = await Geolocator.checkPermission();
      await openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    getLocation(context);
  }

  getLocation(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Position position2 = await Geolocator.getLastKnownPosition();
    print("Last Location-=> ${position2.latitude}");
    print(position.latitude);
    print(position.longitude);
    if (position != null) {
      StorageUtils.writeStringValue(
          StorageUtils.keyLatitude, position.latitude.toString());
      StorageUtils.writeStringValue(
          StorageUtils.keyLongitude, position.longitude.toString());
      print("LAT->>${StorageUtils.readStringValue(StorageUtils.keyLatitude)}");
      // HomeListData().initHomeData(context, 1);
    }
  }
}
