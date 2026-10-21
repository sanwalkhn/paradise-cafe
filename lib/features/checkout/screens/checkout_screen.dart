import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_colors.dart';
import '../../cart/providers/cart_provider.dart';
import '../../orders/providers/orders_provider.dart';
import '../../../data/models/order.dart';
import '../../../data/models/address.dart';
import '../../profile/providers/addresses_provider.dart';
import '../../profile/screens/addresses_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {

  String _selectedPayment = 'Master Card';
  Address? _selectedAddress;

  // ── Open a bottom sheet listing saved addresses to pick from ──
  void _showAddressPicker(List<Address> addresses) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.warmCream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Select Delivery Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...addresses.map((address) {
                final isSelected = _selectedAddress?.id == address.id;
                return InkWell(
                  onTap: () {
                    setState(() => _selectedAddress = address);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          address.label.toLowerCase() == 'home'
                              ? Icons.home_outlined
                              : Icons.work_outline_rounded,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.label,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${address.fullAddress}, ${address.city}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle_rounded, color: AppColors.primary),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddressesScreen()),
                      );
                    },
                    icon: Icon(Icons.add, color: AppColors.primary),
                    label: Text(
                      'Add New Address',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final addressesAsync = ref.watch(addressesProvider);

    final int subtotal = cartNotifier.totalPrice;
    final int deliveryFee = 150;
    final int tax = (subtotal * 0.05).round();
    final int total = subtotal + deliveryFee + tax;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_rounded, color: AppColors.textDark),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  Icon(Icons.more_vert_rounded, color: AppColors.textDark),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Payment Method card ───────────
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.brown.shade100, width: 0.5),
                      ),
                      child: Column(
                        children: [
                          _paymentOption(
                            icon: Icons.credit_card_rounded,
                            iconColor: Colors.deepOrange,
                            title: 'Master Card',
                            subtitle: '******** 8463',
                          ),
                          Divider(height: 1, color: Colors.brown.shade50),
                          _paymentOption(
                            icon: Icons.account_balance_wallet_rounded,
                            iconColor: Colors.blue,
                            title: 'Paypal',
                            subtitle: 'orb****@gmail.com',
                          ),
                          Divider(height: 1, color: Colors.brown.shade50),
                          _paymentOption(
                            icon: Icons.apple_rounded,
                            iconColor: AppColors.textDark,
                            title: 'Apple Pay',
                            subtitle: '',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.brown.shade100, width: 0.5),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_rounded, size: 18, color: AppColors.textDark),
                            const SizedBox(width: 6),
                            Text(
                              'Add Payment Method',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Delivery Address (now from addressesProvider) ──
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    addressesAsync.when(
                      loading: () => Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.brown.shade100, width: 0.5),
                        ),
                        child: Text('Loading...', style: TextStyle(color: AppColors.textSecondary)),
                      ),
                      error: (e, s) => Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.brown.shade100, width: 0.5),
                        ),
                        child: Text('Failed to load addresses', style: TextStyle(color: AppColors.textSecondary)),
                      ),
                      data: (addresses) {
                        // Auto-pick default (or first) address if nothing selected yet
                        if (_selectedAddress == null && addresses.isNotEmpty) {
                          final defaultAddress = addresses.firstWhere(
                            (a) => a.isDefault,
                            orElse: () => addresses.first,
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) setState(() => _selectedAddress = defaultAddress);
                          });
                        }

                        final display = _selectedAddress;

                        return GestureDetector(
                          onTap: () {
                            if (addresses.isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddressesScreen()),
                              );
                            } else {
                              _showAddressPicker(addresses);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.brown.shade100, width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined, color: AppColors.primary),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        display?.label ?? 'No address saved',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        display != null
                                            ? '${display.fullAddress}, ${display.city}'
                                            : 'Tap to add a delivery address',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // ── Order Summary ──────────────────
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    _summaryRow('Order Amount', 'Rs. $subtotal'),
                    const SizedBox(height: 10),
                    _summaryRow('Delivery', 'Rs. $deliveryFee'),
                    const SizedBox(height: 10),
                    _summaryRow('Tax', 'Rs. $tax'),

                    const SizedBox(height: 14),
                    Divider(color: Colors.brown.shade100),
                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          'Rs. $total',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                  ],
                ),
              ),
            ),

            // ── Pay Now button ───────────────────────
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).padding.bottom + 16,
                top: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () async {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) return;

                          final order = Order(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            userId: user.uid,
                            items: cartItems,
                            totalAmount: total,
                            placedAt: DateTime.now(),
                          );

                          await ref.read(ordersRepositoryProvider).addOrder(order);

                          cartNotifier.clearCart();

                          if (!context.mounted) return;

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _paymentOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedPayment == title;
    return InkWell(
      onTap: () => setState(() => _selectedPayment = title),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.textDark : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.textDark : Colors.brown.shade200,
                  width: 1.5,
                ),
              ),
              child: isSelected ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
      ],
    );
  }
}