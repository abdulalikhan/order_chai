import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_chai/models/chai.dart';
import 'package:order_chai/models/user.dart';

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

  // chai list from snapshot
  List<Chai> _chaiListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Chai(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 100,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  // get chais stream
  Stream<List<Chai>> get chais {
    return chaiCollection.snapshots().map(_chaiListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return chaiCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
