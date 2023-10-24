// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Let's look for mushrooms together...`
  String get splashTitle {
    return Intl.message(
      'Let\'s look for mushrooms together...',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login please...\n`
  String get logInTitle {
    return Intl.message(
      'Login please...\n',
      name: 'logInTitle',
      desc: '',
      args: [],
    );
  }

  /// `LogIn`
  String get buttonLogIN {
    return Intl.message(
      'LogIn',
      name: 'buttonLogIN',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get buttonRegistration {
    return Intl.message(
      'Registration',
      name: 'buttonRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Create account.\nEnter your email and password`
  String get registrationTitle {
    return Intl.message(
      'Create account.\nEnter your email and password',
      name: 'registrationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Some problems.\nCheck your email/password`
  String get errorTitle {
    return Intl.message(
      'Some problems.\nCheck your email/password',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak`
  String get errorTitleWeakPassword {
    return Intl.message(
      'The password provided is too weak',
      name: 'errorTitleWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email`
  String get errorTitleEmailInUse {
    return Intl.message(
      'The account already exists for that email',
      name: 'errorTitleEmailInUse',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email\n`
  String get errorTitleNoUser {
    return Intl.message(
      'No user found for that email\n',
      name: 'errorTitleNoUser',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user\n`
  String get errorTitleWrongPassword {
    return Intl.message(
      'Wrong password provided for that user\n',
      name: 'errorTitleWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection not found\n`
  String get errorTitleNoInternetConnection {
    return Intl.message(
      'Internet connection not found\n',
      name: 'errorTitleNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Registration success`
  String get registrationSuccessTitle {
    return Intl.message(
      'Registration success',
      name: 'registrationSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `I don't have an account`
  String get noAccountTitle {
    return Intl.message(
      'I don\'t have an account',
      name: 'noAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the fields `
  String get validationSnackBarMessage {
    return Intl.message(
      'Fill in the fields ',
      name: 'validationSnackBarMessage',
      desc: '',
      args: [],
    );
  }

  /// `EMAIL`
  String get textFieldHintEmail {
    return Intl.message(
      'EMAIL',
      name: 'textFieldHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `PASSWORD`
  String get textFieldHintPassword {
    return Intl.message(
      'PASSWORD',
      name: 'textFieldHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get appBarTitle {
    return Intl.message(
      'Settings',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search friend`
  String get bottomNavigationBarItemLabelSearchFriend {
    return Intl.message(
      'Search friend',
      name: 'bottomNavigationBarItemLabelSearchFriend',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get bottomNavigationBarItemLabelSettings {
    return Intl.message(
      'Settings',
      name: 'bottomNavigationBarItemLabelSettings',
      desc: '',
      args: [],
    );
  }

  /// `Friend's ID`
  String get textFieldHintFriendId {
    return Intl.message(
      'Friend\'s ID',
      name: 'textFieldHintFriendId',
      desc: '',
      args: [],
    );
  }

  /// `Friend's name`
  String get textFieldHintFriendName {
    return Intl.message(
      'Friend\'s name',
      name: 'textFieldHintFriendName',
      desc: '',
      args: [],
    );
  }

  /// `Your ID`
  String get yourIdText {
    return Intl.message(
      'Your ID',
      name: 'yourIdText',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get enterYourNameText {
    return Intl.message(
      'Enter your Name',
      name: 'enterYourNameText',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get textFieldHintYourName {
    return Intl.message(
      'Name',
      name: 'textFieldHintYourName',
      desc: '',
      args: [],
    );
  }

  /// `LogOut and close App?`
  String get logOutAlertDialogTitle {
    return Intl.message(
      'LogOut and close App?',
      name: 'logOutAlertDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete friend?`
  String get deleteFriendDialogTitle {
    return Intl.message(
      'Delete friend?',
      name: 'deleteFriendDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `ACCEPT`
  String get alertDialogAccept {
    return Intl.message(
      'ACCEPT',
      name: 'alertDialogAccept',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get alertDialogCancel {
    return Intl.message(
      'CANCEL',
      name: 'alertDialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Copied to your clipboard`
  String get copyIDSnackBarMessage {
    return Intl.message(
      'Copied to your clipboard',
      name: 'copyIDSnackBarMessage',
      desc: '',
      args: [],
    );
  }

  /// `ADD`
  String get addFriendButtonTitle {
    return Intl.message(
      'ADD',
      name: 'addFriendButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name saved`
  String get savedNameSnackBarMessage {
    return Intl.message(
      'Name saved',
      name: 'savedNameSnackBarMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send this ID to your friends`
  String get sendIDMessage {
    return Intl.message(
      'Send this ID to your friends',
      name: 'sendIDMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk', countryCode: 'UA'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
