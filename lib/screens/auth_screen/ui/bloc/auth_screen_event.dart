part of 'auth_screen_bloc.dart';

abstract class AuthScreenEvent {}

class OnAuthButtonClick extends AuthScreenEvent {
  final String email;
  final String password;
  final BuildContext context;
  OnAuthButtonClick({required this.email, required this.password, required this.context});
}

class CheckBoxClickOn extends AuthScreenEvent {
}

class CheckBoxClickOff extends AuthScreenEvent {
  CheckBoxClickOff({required this.context});
  final BuildContext context;
}
