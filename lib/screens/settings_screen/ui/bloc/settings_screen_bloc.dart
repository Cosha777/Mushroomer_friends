import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mushroom_friends/screens/auth_screen/data/repositories/firebase_auth_service.dart';

import 'package:mushroom_friends/screens/settings_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';
import 'package:mushroom_friends/screens/settings_screen/domain/friend_model.dart';

part 'settings_screen_event.dart';

part 'settings_screen_state.dart';

class SettingsScreenBloc
    extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  final SettingsFireStoreService _settingsFireStoreService;
  final FireBaseAuthService _fireBaseAuthService;
  LocalDataService localDataService = LocalDataSourceSharedPref();

  SettingsScreenBloc(this._settingsFireStoreService, this._fireBaseAuthService)
      : super(SettingsScreenInitial()) {
    on<LoadFriendList>((event, emit) async {
      var friendList = await _settingsFireStoreService.getDataFromDB();
      emit(Loaded(friendList: friendList));
    });

    on<AddFriendToFriendList>((event, emit) async {
      await _settingsFireStoreService.addFriendToDB(event.friendModel);
      emit(SettingsScreenInitial());
    });

    on<CheckboxClick>((event, emit) async {
      var friendList = await _settingsFireStoreService.getDataFromDB();
      FriendModel item = friendList[event.index];
      item = item.copyWith(isShowed: !item.isShowed);

      await _settingsFireStoreService.addFriendToDB(item);
      emit(SettingsScreenInitial());
    });

    on<DeleteFriendFromFriendList>((event, emit) async {
      await _settingsFireStoreService.removeFriendFromDB(event.id);
      emit(SettingsScreenInitial());
    });

    on<LogOutAcceptClick>((event, emit) async {
      _fireBaseAuthService.logOut();
      SystemNavigator.pop();
    });

    on<SaveName>((event, emit) async {
      localDataService.setNameToLocalSource(event.name);
    });
  }
}
