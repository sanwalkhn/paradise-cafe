import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final bool orderUpdatesEnabled;
  final bool promoNotificationsEnabled;

  SettingsState({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.orderUpdatesEnabled = true,
    this.promoNotificationsEnabled = true,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    bool? orderUpdatesEnabled,
    bool? promoNotificationsEnabled,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      orderUpdatesEnabled: orderUpdatesEnabled ?? this.orderUpdatesEnabled,
      promoNotificationsEnabled:
          promoNotificationsEnabled ?? this.promoNotificationsEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState()) {
    _loadSettings();
  }

  // ── Load saved prefs when the app starts ──────────
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = SettingsState(
      notificationsEnabled: prefs.getBool('notificationsEnabled') ?? true,
      darkModeEnabled: prefs.getBool('darkModeEnabled') ?? false,
      orderUpdatesEnabled: prefs.getBool('orderUpdatesEnabled') ?? true,
      promoNotificationsEnabled:
          prefs.getBool('promoNotificationsEnabled') ?? true,
    );
  }

  Future<void> toggleNotifications(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
  }

  Future<void> toggleDarkMode(bool value) async {
    state = state.copyWith(darkModeEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkModeEnabled', value);
  }

  Future<void> toggleOrderUpdates(bool value) async {
    state = state.copyWith(orderUpdatesEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('orderUpdatesEnabled', value);
  }

  Future<void> togglePromoNotifications(bool value) async {
    state = state.copyWith(promoNotificationsEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('promoNotificationsEnabled', value);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});