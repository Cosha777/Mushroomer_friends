import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel{
   String? id;

  AuthUserModel.fromFireBase(User user){
    id = user.uid;
  }
}