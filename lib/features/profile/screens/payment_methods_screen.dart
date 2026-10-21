import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PaymentMethod {
  final String id;
  final String type;        // 'card' or 'cod'
  final String label;       // e.g. "Visa •••• 4242"
  final String? expiry;      // e.g. "12/27" — null for COD
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.label,
    this.expiry,
    this.isDefault = false,
  });

  PaymentMethod copyWith({bool? isDefault}) {
    return PaymentMethod(
      id: id,
      type: type,
      label: label,
      expiry: expiry,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {

  // ── Local list — starts with Cash on Delivery as the default ──
  List<PaymentMethod> _methods = [
    PaymentMethod(
      id: 'cod',
      type: 'cod',
      label: 'Cash on Delivery',
      isDefault: true,
    ),
  ];

  void _setDefault(String id) {
    setState(() {
      _methods = _methods.map((m) {
        return m.copyWith(isDefault: m.id == id);
      }).toList();
    });
  }

  void _removeMethod(String id) {
    setState(() {
      _methods.removeWhere((m) => m.id == id);
      // if we just removed the default, make COD default again (if it still exists)
      if (!_methods.any((m) => m.isDefault) && _methods.isNotEmpty) {
        _methods[0] = _methods[0].copyWith(isDefault: true);
      }
    });
  }

  void _showAddCardSheet() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    final nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.warmCream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'For demo purposes — no real payment is processed',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: nameController,
                decoration: _fieldDecoration('Cardholder name'),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 19,
                decoration: _fieldDecoration('Card number').copyWith(
                  counterText: '',
                  hintText: '1234 5678 9012 3456',
                ),
              ),
              const SizedBox(height: 4),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      keyboardType: TextInputType.datetime,
                      maxLength: 5,
                      decoration: _fieldDecoration('MM/YY').copyWith(counterText: ''),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      obscureText: true,
                      decoration: _fieldDecoration('CVV').copyWith(counterText: ''),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (cardNumberController.text.trim().length < 4) return;

                    final last4 = cardNumberController.text
                        .replaceAll(' ', '')
                        .padLeft(4, '0')
                        .substring(
                          cardNumberController.text.replaceAll(' ', '').length >= 4
                              ? cardNumberController.text.replaceAll(' ', '').length - 4
                              : 0,
                        );

                    setState(() {
                      _methods.add(PaymentMethod(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        type: 'card',
                        label: 'Card •••• $last4',
                        expiry: expiryController.text.trim(),
                      ));
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Save Card',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13, color: AppColors.textHint),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    'Payment Methods',
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
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _methods.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final method = _methods[index];
                  return _methodCard(method);
                },
              ),
            ),

            // ── Add card button ────────────────────
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).padding.bottom + 16,
                top: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _showAddCardSheet,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add New Card',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // ── Payment method card helper widget ────────────
  Widget _methodCard(PaymentMethod method) {
    final isCod = method.type == 'cod';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: method.isDefault ? AppColors.primary : Colors.brown.shade100,
          width: method.isDefault ? 1.5 : 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCod ? Icons.payments_outlined : Icons.credit_card_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    if (method.isDefault) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTint,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (method.expiry != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Expires ${method.expiry}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!method.isDefault)
            GestureDetector(
              onTap: () => _setDefault(method.id),
              child: Text(
                'Set default',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          if (!isCod)
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
              onPressed: () => _removeMethod(method.id),
            ),
        ],
      ),
    );
  }
}