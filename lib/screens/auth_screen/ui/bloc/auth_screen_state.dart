part of 'auth_screen_bloc.dart';

abstract class AuthScreenState {
  final String title;
  final String buttonTitle;
  final bool checkBox;

  AuthScreenState(
      {required this.title, required this.buttonTitle, required this.checkBox});
}

class AuthScreenLogIn extends AuthScreenState {
  AuthScreenLogIn()
      : super(
            title: S.current.logInTitle,
            buttonTitle: S.current.buttonLogIN,
            checkBox: false);
}

class AuthScreenRegister extends AuthScreenState {
  AuthScreenRegister()
      : super(
            title: S.current.registrationTitle,
            buttonTitle: S.current.buttonRegistration,
            checkBox: true);
}

class IsRegistered extends AuthScreenState {
  IsRegistered()
      : super(
            title: S.current.registrationSuccessTitle,
            buttonTitle: S.current.buttonLogIN,
            checkBox: false);
}

class ErrorState extends AuthScreenState {
  ErrorState({required super.title})
      : super(buttonTitle: S.current.buttonLogIN, checkBox: false);
}
