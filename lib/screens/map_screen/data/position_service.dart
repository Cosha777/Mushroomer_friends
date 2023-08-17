import 'dart:async';
import 'package:geolocator/geolocator.dart';

class PositionService {
  Future<Stream<Position>> getMyPosition() async {
    const LocationSettings locationSettings =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
