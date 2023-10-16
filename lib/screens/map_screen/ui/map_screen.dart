import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:mushroom_friends/screens/map_screen/ui/map_screen_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapScreenModel _model;

  @override
  void initState() {
    super.initState();
    context.read<MapScreenModel>().listenLocationChanges();
    context.read<MapScreenModel>().getQueryStream();
    _model = context.read<MapScreenModel>();
  }

  @override
  void dispose() {
    _model.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          GoogleMap(
            polylines: context.watch<MapScreenModel>().polylines,
            markers: context.watch<MapScreenModel>().markers,
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(50.425455, 30.448227),
              zoom: 16,
            ),
          ),
          Positioned(
            top: 50,
            left: 7,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settingsScreen');
              },
              icon: const Icon(
                Icons.menu_rounded,
              ),
              color: Colors.black38,
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(
                  BorderSide(
                    color: Colors.blue,
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
