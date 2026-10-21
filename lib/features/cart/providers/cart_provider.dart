import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/cart_item.dart';

// ── The state notifier — holds and manages the cart list ────
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);   // starts as an empty cart

  // ── Add an item (or increase quantity if it already exists) ──
  void addItem({
    required String name,
    required int price,
    required String image,
    required int quantity,
  }) {
    // check if this item is already in the cart
    final existingIndex = state.indexWhere((item) => item.name == name);

    if (existingIndex != -1) {
      // already in cart — just increase its quantity
      final updatedItem = state[existingIndex];
      updatedItem.quantity += quantity;
      state = [...state];   // trigger rebuild with a new list reference
    } else {
      // not in cart yet — add it as a new entry
      state = [
        ...state,
        CartItem(name: name, price: price, image: image, quantity: quantity),
      ];
    }
  }

  // ── Increase quantity of one item ────────────────
  void incrementQuantity(String name) {
    final index = state.indexWhere((item) => item.name == name);
    if (index != -1) {
      state[index].quantity++;
      state = [...state];
    }
  }

  // ── Decrease quantity of one item (removes if it hits 0) ──
  void decrementQuantity(String name) {
    final index = state.indexWhere((item) => item.name == name);
    if (index != -1) {
      if (state[index].quantity > 1) {
        state[index].quantity--;
        state = [...state];
      } else {
        removeItem(name);
      }
    }
  }

  // ── Remove an item entirely ───────────────────────
  void removeItem(String name) {
    state = state.where((item) => item.name != name).toList();
  }

  // ── Clear the whole cart ──────────────────────────
  void clearCart() {
    state = [];
  }

  // ── Computed total price of everything in the cart ──
  int get totalPrice {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // ── Computed total number of items (counting quantities) ──
  int get totalItemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

// ── The provider itself — this is what screens will "watch" ──
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});