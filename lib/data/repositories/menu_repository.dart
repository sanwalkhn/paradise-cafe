import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item.dart';

class MenuRepository {
  final _firestore = FirebaseFirestore.instance;

  // ── Fetch all menu items once ─────────────────────
  Future<List<MenuItem>> getAllItems() async {
    final snapshot = await _firestore.collection('menu_items').get();

    return snapshot.docs.map((doc) {
      return MenuItem.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  // ── Fetch items filtered by category ──────────────
  Future<List<MenuItem>> getItemsByCategory(String category) async {
    final snapshot = await _firestore
        .collection('menu_items')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs.map((doc) {
      return MenuItem.fromFirestore(doc.id, doc.data());
    }).toList();
  }
}