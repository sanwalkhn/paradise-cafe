import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address.dart';

class AddressesRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addAddress(Address address) async {
    await _firestore.collection('addresses').doc(address.id).set(address.toMap());
  }

  Future<void> deleteAddress(String id) async {
    await _firestore.collection('addresses').doc(id).delete();
  }

  // ── Set one address as default, unset all others for this user ──
  Future<void> setDefault(String userId, String addressId) async {
    final batch = _firestore.batch();
    final userAddresses = await _firestore
        .collection('addresses')
        .where('userId', isEqualTo: userId)
        .get();

    for (var doc in userAddresses.docs) {
      batch.update(doc.reference, {'isDefault': doc.id == addressId});
    }
    await batch.commit();
  }

  Stream<List<Address>> streamUserAddresses(String userId) {
    return _firestore
        .collection('addresses')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Address.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }
}