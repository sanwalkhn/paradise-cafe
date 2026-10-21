import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/menu_item.dart';
import '../../../data/repositories/menu_repository.dart';
import '../../../data/models/menu_item.dart';

// ── Repository instance provider ──────────────────
final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepository();
});

// ── Fetches all menu items from Firestore ─────────
final allMenuItemsProvider = FutureProvider<List<MenuItem>>((ref) async {
  final repository = ref.watch(menuRepositoryProvider);
  return repository.getAllItems();
});

// ── Fetches menu items filtered by category ───────
final menuItemsByCategoryProvider =
    FutureProvider.family<List<MenuItem>, String>((ref, category) async {
  final repository = ref.watch(menuRepositoryProvider);
  return repository.getItemsByCategory(category);
});