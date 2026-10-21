import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/orders_repository.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepository();
});

// ── Live stream of the current user's orders ───────
final ordersProvider = StreamProvider<List<Order>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value([]);
  }

  final repository = ref.watch(ordersRepositoryProvider);
  return repository.streamUserOrders(user.uid);
});