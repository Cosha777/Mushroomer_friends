import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mushroom_friends/screens/map_screen/domain/mushroomer_model.dart';

class MarkersModel {
  late Set<Marker> _markers;

  Future<Set<Marker>> createMarkers(
      List<MushroomerModel> list, Position? myPosition) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/friend2.png",
    );
    _markers = {};
    for (var element in list) {
      final authUserID = FirebaseAuth.instance.currentUser?.uid;
      if (element.id != authUserID) {
        var distance = distanceCalc(element, myPosition);
        _markers.add(
          Marker(
            markerId: MarkerId(element.id!),
            position: element.position!,
            infoWindow: InfoWindow(
              title: element.name,
              snippet: '${distance.toInt()}m',
            ),
            icon: icon,
          ),
        );
      }
    }
    return _markers;
  }

  double distanceCalc(MushroomerModel element, Position? myPosition) {
    if (myPosition != null) {
      return Geolocator.distanceBetween(
          element.position!.latitude,
          element.position!.longitude,
          myPosition.latitude,
          myPosition.longitude);
    } else {
      return 0;
    }
  }
}
