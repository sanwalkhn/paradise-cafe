import 'cart_item.dart';

enum OrderStatus { pending, preparing, onTheWay, delivered, cancelled }

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final int totalAmount;
  final DateTime placedAt;
  final OrderStatus status;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.placedAt,
    this.status = OrderStatus.pending,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  // ── Convert this Order into a Firestore-friendly map ──
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalAmount': totalAmount,
      'placedAt': placedAt.millisecondsSinceEpoch,
      'status': status.name,
      'items': items.map((item) => {
        'name': item.name,
        'price': item.price,
        'image': item.image,
        'quantity': item.quantity,
      }).toList(),
    };
  }

  // ── Convert raw Firestore data into an Order ──────
  factory Order.fromFirestore(String id, Map<String, dynamic> data) {
    final itemsList = (data['items'] as List<dynamic>? ?? []);

    return Order(
      id: id,
      userId: data['userId'] ?? '',
      totalAmount: (data['totalAmount'] ?? 0).toInt(),
      placedAt: DateTime.fromMillisecondsSinceEpoch(data['placedAt'] ?? 0),
      status: OrderStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => OrderStatus.pending,
      ),
      items: itemsList.map((item) {
        return CartItem(
          name: item['name'] ?? '',
          price: (item['price'] ?? 0).toInt(),
          image: item['image'] ?? '',
          quantity: (item['quantity'] ?? 1).toInt(),
        );
      }).toList(),
    );
  }
}