import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mushroom_friends/screens/settings_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/settings_screen/domain/friend_model.dart';

class FriendListFactory {
  FriendListFactory(this.settingsFireStoreService);

  final SettingsFireStoreService settingsFireStoreService;

  StreamSubscription<List<FriendModel>>? queryStreamSubscription;
  StreamController<List<String>> friendListStreamController =
      StreamController();

  StreamController<List<String>>? listenSettingsStream() {
    final data = settingsFireStoreService.getDataStreamFromDB();

    queryStreamSubscription = data.listen((event) {
      List<String> list = [FirebaseAuth.instance.currentUser!.uid];
      for (var element in event) {
        if (element.isShowed == true) {
          list.add(element.id);
        }
      }
      friendListStreamController.add(list);
    });
    return friendListStreamController;
  }

  void streamsCancel() {
    queryStreamSubscription?.cancel();
  }
}
