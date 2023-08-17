import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/screens/auth_screen/domain/authuser_model.dart';

class FireBaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      return AuthUserModel.fromFireBase(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw S.current.errorTitleWeakPassword;
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw S.current.errorTitleEmailInUse;
        //print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return AuthUserModel.fromFireBase(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw S.current.errorTitleNoUser;
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw S.current.errorTitleWrongPassword;
        //print('Wrong password provided for that user.');
      }
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream<AuthUserModel?> get currentUser {
    return _auth.authStateChanges().map(
        (User? user) => user != null ? AuthUserModel.fromFireBase(user) : null);
  }
}
