import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/order.dart';

class OrdersRepository {
  final _firestore = FirebaseFirestore.instance;

  // ── Save a new order to Firestore ─────────────────
  Future<void> addOrder(Order order) async {
    await _firestore.collection('orders').doc(order.id).set(order.toMap());
  }

  // ── Live stream of a user's orders, newest first ──
  Stream<List<Order>> streamUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('placedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Order.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }
}