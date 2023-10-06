import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mushroomer_model.dart';

class PolylinesModel {
  late Set<Polyline> _polylines;

  Set<Polyline> createPolylines(
      List<MushroomerModel> snapshot, Position? myPosition) {
    _polylines = {};
    for (var element in snapshot) {
      _polylines.add(Polyline(
        polylineId: PolylineId(element.id!),
        visible: true,
        width: 2,
        points: [
          LatLng(myPosition!.latitude, myPosition.longitude), //start point
          element.position!, //end point
        ],
        color: Colors.deepPurpleAccent,
      ));
    }
    return _polylines;
  }
}
