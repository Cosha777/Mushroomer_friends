import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/internet.dart';
import 'package:mushroom_friends/screens/auth_screen/data/repositories/firebase_auth_service.dart';
import 'package:mushroom_friends/screens/auth_screen/domain/authuser_model.dart';

part 'auth_screen_event.dart';

part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  final FireBaseAuthService _fireBaseAuthService;

  AuthScreenBloc(
    this._fireBaseAuthService,
  ) : super(AuthScreenLogIn()) {
    on<CheckBoxClickOn>((event, emit) async {
      emit(AuthScreenRegister());
    });

    on<CheckBoxClickOff>((event, emit) async {
      emit(AuthScreenLogIn());
    });

    on<OnAuthButtonClick>((event, emit) async {
      try {
        AuthUserModel? user = state.checkBox
            ? await _fireBaseAuthService.createUserWithEmailAndPassword(
                email: event.email, password: event.password)
            : await _fireBaseAuthService.signInWithEmailAndPassword(
                email: event.email, password: event.password);
        if (user != null) {
          emit(IsRegistered());
          if (event.context.mounted) {
            Navigator.pushNamed(event.context, '/mapScreen');
          }
        } else {
          await Internet.isInternetConnected()
              ? emit(ErrorState(title: S.current.errorTitle))
              : emit(
                  ErrorState(title: S.current.errorTitleNoInternetConnection));
        }
      } catch (e) {
        emit(ErrorState(title: e.toString()));
      }
    });
  }
}
