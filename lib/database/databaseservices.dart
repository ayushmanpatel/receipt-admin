import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference koshCollection =
      FirebaseFirestore.instance.collection('bankapi');

  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('datacollection');

  Future updateUserData(String _upiRefId, String _debit, String _credit,
      bool _isVerified, var date) async {
    return await koshCollection.doc().set({
      'id': _upiRefId,
      'debit': _debit,
      'credit': _credit,
      'verified': _isVerified,
      'date': date
    });
  }

  Future deleteEntries(String docId) async {
    return await koshCollection.doc(docId).delete();
  }

  Future datacollection(int totalentry, int verified) async {
    return await dataCollection
        .doc('entries')
        .set({'total_entry': totalentry, 'total_verified': verified});
  }
}
