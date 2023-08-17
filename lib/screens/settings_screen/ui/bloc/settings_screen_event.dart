part of 'settings_screen_bloc.dart';

@immutable
abstract class SettingsScreenEvent {}

class AddFriendToFriendList extends SettingsScreenEvent {
  AddFriendToFriendList({required this.friendModel});

  final FriendModel friendModel;
}

class DeleteFriendFromFriendList extends SettingsScreenEvent {
  DeleteFriendFromFriendList({required this.id});

  final String id;
}

class CheckboxClick extends SettingsScreenEvent {
  CheckboxClick({required this.index});

  final int index;
}

class LoadFriendList extends SettingsScreenEvent {}

class LogOutAcceptClick extends SettingsScreenEvent {}

class SaveName extends SettingsScreenEvent {
  SaveName({required this.name});

  final String name;
}
