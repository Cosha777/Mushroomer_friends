import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mushroom_friends/screens/settings_screen/domain/friend_model.dart';

class SettingsFireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final authUserID = FirebaseAuth.instance.currentUser?.uid;

  Future<void> addFriendToDB(FriendModel model) async {
    return await db.collection(authUserID!).doc(model.id).set(model.toMap());
  }

  Stream<List<FriendModel>> getDataStreamFromDB() {
    return db.collection(authUserID!).snapshots().map((QuerySnapshot data) =>
        data.docs
            .map((DocumentSnapshot document) => FriendModel.fromDB(
                document.id, document.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<FriendModel>> getDataFromDB() async {
    QuerySnapshot snapshot = await db.collection(authUserID!).get();
    List<FriendModel> list = snapshot.docs
        .map((DocumentSnapshot document) => FriendModel.fromDB(
            document.id, document.data() as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<void> removeFriendFromDB(String id) {
    return db.collection(authUserID!).doc(id).delete();
  }
  // Query<Map<String, dynamic>> find() {
  //   return db.where(FieldPath.documentId, isEqualTo:
  //       "qqqqqqqqqqqqqqqqqqqqqqqqqqq" );
  // }
}
