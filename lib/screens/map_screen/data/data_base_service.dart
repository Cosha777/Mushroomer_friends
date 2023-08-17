import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mushroom_friends/screens/map_screen/domain/mushroomer_model.dart';

class MapFireStoreService {
  final CollectionReference _mushroomerCollection =
      FirebaseFirestore.instance.collection('Mushroomers');

  Future<void> addMushroomerToDB(MushroomerModel mush) async {
    final authUserID = FirebaseAuth.instance.currentUser?.uid;
    return await _mushroomerCollection
        .doc(authUserID)
        .set(mush.mushroomerToDB());
  }

  Stream<List<MushroomerModel>> getDataFromDB(List<String> query) {
    return _mushroomerCollection
        .where(FieldPath.documentId, whereIn: query)
        .snapshots()
        .map((QuerySnapshot data) => data.docs
            .map((DocumentSnapshot document) => MushroomerModel.fromDB(
                document.id, document.data() as Map<String, dynamic>))
            .toList());
  }
}
