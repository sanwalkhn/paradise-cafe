import 'package:flutter_riverpod/flutter_riverpod.dart';

// 0 = Home, 1 = Search, 2 = Cart, 3 = Orders, 4 = Profile
final mainTabProvider = StateProvider<int>((ref) => 0);