part of 'settings_screen_bloc.dart';

@immutable
abstract class SettingsScreenState {}

class SettingsScreenInitial extends SettingsScreenState {}

class Loaded extends SettingsScreenState {
  final List<FriendModel> friendList;

  Loaded({required this.friendList});
}
