import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference chaiCollection =
      Firestore.instance.collection('chais');
  Future updateUserData(String sugars, String name, int strength) async {
    return await chaiCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
}
