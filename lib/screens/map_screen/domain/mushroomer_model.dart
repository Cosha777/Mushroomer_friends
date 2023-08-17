import 'package:google_maps_flutter/google_maps_flutter.dart';

class MushroomerModel {
  final String? id;
  final String name;
  final LatLng? position;

  MushroomerModel(
      {required this.id, required this.name, required this.position});

  Map<String, dynamic> mushroomerToDB() {
    return {
      'id': id,
      'name': name,
      'position': position?.toJson(),
    };
  }

  MushroomerModel.fromDB(String idUser, Map<String, dynamic> data)
      : id = idUser,
        name = data['name'],
        position = LatLng(data['position'][0], data['position'][1]);
}
