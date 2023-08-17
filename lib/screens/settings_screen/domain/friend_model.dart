class FriendModel {
  final String id;
  final String name;
  final bool isShowed;

  FriendModel({required this.id, required this.name, required this.isShowed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isShowed': isShowed,
    };
  }

  FriendModel.fromDB(String idUser, Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        isShowed = data['isShowed'];

  FriendModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isShowed = json['isShowed'];

  FriendModel copyWith({
    String? id,
    String? name,
    bool? isShowed,
  }) {
    return FriendModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isShowed: isShowed ?? this.isShowed,
    );
  }
}
