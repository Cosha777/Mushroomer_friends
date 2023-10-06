import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mushroom_friends/screens/map_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/map_screen/domain/mushroomer_model.dart';
import 'package:mushroom_friends/screens/map_screen/data/position_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/friend_list_factory.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';

import '../domain/markers_model.dart';
import '../domain/polylines_model.dart';

class MapScreenModel extends ChangeNotifier {
  MapScreenModel(
      this.mapFireStoreService,
      this.localDataService,
      this.friendListFactory,
      this.positionService,
      this.markersModel,
      this.polylinesModel);

  final MapFireStoreService mapFireStoreService;
  final LocalDataService localDataService;
  final FriendListFactory friendListFactory;
  final PositionService positionService;
  final MarkersModel markersModel;
  final PolylinesModel polylinesModel;

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
    friendsListListener = friendListStream.listen((event) async {
      markers = await markersModel.createMarkers(event, myPosition);
      polylines = polylinesModel.createPolylines(event, myPosition);
      notifyListeners();
    });
  }

  Future<void> cancel() async {
    myPositionStreamListener?.cancel();
    friendsListListener?.cancel();
    queryStreamListener?.cancel();
  }
}
