import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mushroom_friends/screens/map_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/map_screen/domain/mushroomer_model.dart';
import 'package:mushroom_friends/screens/map_screen/data/position_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/friend_list_factory.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';

class MapScreenModel extends ChangeNotifier {
  MapScreenModel(this.mapFireStoreService, this.localDataService,
      this.friendListFactory, this.positionService);

  final MapFireStoreService mapFireStoreService;
  final LocalDataService localDataService;
  final FriendListFactory friendListFactory;
  final PositionService positionService;

  Position? myPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  StreamSubscription<Position>? myPositionStreamListener;
  StreamSubscription<List<MushroomerModel>>? friendsListListener;
  StreamSubscription<List<String>>? queryStreamListener;
  List<String> friendList = [''];

  Future<void> listenLocationChanges() async {
    myPosition = await Geolocator.getLastKnownPosition();
    var myPositionStream = await positionService.getMyPosition();
    myPositionStreamListener = myPositionStream.listen((Position? position) {
      myPosition = position!;
      addMushroomer(position);
    });
  }

  Future<void> addMushroomer(Position? position) async {
    var name = await localDataService.getNameFromLocalSource();
    mapFireStoreService.addMushroomerToDB(MushroomerModel(
        id: '0',
        position: LatLng(position!.latitude, position.longitude),
        name: name));
  }

  void getQueryStream() {
    var queryFriendList = friendListFactory.listenSettingsStream();
    queryStreamListener = queryFriendList?.stream.listen((event) {
      friendsListListener?.cancel();
      friendList = event;
      createMap();
    });
  }

  void createMap() {
    var friendListStream = mapFireStoreService.getDataFromDB(friendList);
    friendsListListener = friendListStream.listen((event) {
      createMarkers(event);
      createPolylines(event);
      notifyListeners();
    });
  }

  void createMarkers(List<MushroomerModel> snapshot) {
    Set<Marker> markers1 = {};
    for (var element in snapshot) {
      final authUserID = FirebaseAuth.instance.currentUser?.uid;
      if (element.id != authUserID) {
        final distance = distanceCalc(element);
        markers1.add(
          Marker(
            markerId: MarkerId(element.id!),
            position: element.position!,
            infoWindow: InfoWindow(
                title: element.name, snippet: distance.toInt().toString()),
          ),
        );
      }
    }
    markers = markers1;
  }

  void createPolylines(List<MushroomerModel> snapshot) {
    Set<Polyline> polylines1 = {};
    for (var element in snapshot) {
      polylines1.add(Polyline(
        polylineId: PolylineId(element.id!),
        visible: true,
        width: 2,
        points: [
          LatLng(myPosition!.latitude, myPosition!.longitude), //start point
          element.position!, //end point
        ],
        color: Colors.deepPurpleAccent,
      ));
    }
    polylines = polylines1;
  }

  double distanceCalc(MushroomerModel element) {
    return Geolocator.distanceBetween(
        element.position!.latitude,
        element.position!.longitude,
        myPosition!.latitude,
        myPosition!.longitude);
  }

  Future<void> cancel() async {
    myPositionStreamListener?.cancel();
    friendsListListener?.cancel();
    queryStreamListener?.cancel();
  }
}
