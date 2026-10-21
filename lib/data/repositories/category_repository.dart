import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getAllCategories() async {
    final snapshot = await _firestore
        .collection('categories')
        .orderBy('order')
        .get();

    return snapshot.docs.map((doc) {
      return Category.fromFirestore(doc.id, doc.data());
    }).toList();
  }
}