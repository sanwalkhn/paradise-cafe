import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Header ─────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_rounded, color: AppColors.textDark),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _sectionLabel('Appearance'),
                    const SizedBox(height: 10),
                    _settingsCard(
                      children: [
                        _switchTile(
                          icon: Icons.dark_mode_outlined,
                          label: 'Dark Mode',
                          subtitle: 'Coming soon',
                          value: settings.darkModeEnabled,
                          onChanged: (value) {
                            settingsNotifier.toggleDarkMode(value);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Dark mode coming in a future update'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _sectionLabel('Notifications'),
                    const SizedBox(height: 10),
                    _settingsCard(
                      children: [
                        _switchTile(
                          icon: Icons.notifications_outlined,
                          label: 'Push Notifications',
                          subtitle: 'Master switch for all alerts',
                          value: settings.notificationsEnabled,
                          onChanged: (value) {
                            settingsNotifier.toggleNotifications(value);
                          },
                        ),
                        _divider(),
                        _switchTile(
                          icon: Icons.receipt_long_outlined,
                          label: 'Order Updates',
                          subtitle: 'Status changes for your orders',
                          value: settings.orderUpdatesEnabled,
                          onChanged: settings.notificationsEnabled
                              ? (value) => settingsNotifier.toggleOrderUpdates(value)
                              : null,
                        ),
                        _divider(),
                        _switchTile(
                          icon: Icons.local_offer_outlined,
                          label: 'Promotions & Offers',
                          subtitle: 'Deals and discount alerts',
                          value: settings.promoNotificationsEnabled,
                          onChanged: settings.notificationsEnabled
                              ? (value) => settingsNotifier.togglePromoNotifications(value)
                              : null,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _sectionLabel('About'),
                    const SizedBox(height: 10),
                    _settingsCard(
                      children: [
                        _infoTile(icon: Icons.info_outline_rounded, label: 'App Version', value: '1.0.0'),
                        _divider(),
                        _infoTile(icon: Icons.language_outlined, label: 'Language', value: 'English'),
                      ],
                    ),

                    const SizedBox(height: 24),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // ── Section label helper widget ──────────────────
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ── Card wrapper helper widget ───────────────────
  Widget _settingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.brown.shade100, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  // ── Switch tile helper widget (disabled when onChanged is null) ──
  Widget _switchTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    final isDisabled = onChanged == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isDisabled ? AppColors.textHint : AppColors.textDark,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDisabled ? AppColors.textHint : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ── Info tile helper widget (read-only row) ──────
  Widget _infoTile({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.textDark),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Divider helper widget ─────────────────────────
  Widget _divider() {
    return Divider(height: 1, thickness: 0.5, indent: 52, color: Colors.brown.shade100);
  }
}