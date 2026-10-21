import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {

  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I track my order?',
      'answer':
          'Go to the Orders tab from the bottom navigation bar. Each order shows its current status — Pending, Preparing, On the Way, or Delivered — updated in real time.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'Currently we support Cash on Delivery. Card and wallet payments are coming soon under Payment Methods in your Profile.',
    },
    {
      'question': 'Can I cancel my order after placing it?',
      'answer':
          'Orders can be cancelled only while status is still Pending. Once the restaurant starts preparing your order, cancellation is no longer available. Contact support below for urgent cases.',
    },
    {
      'question': 'How do I change my delivery address?',
      'answer':
          'Go to Profile → Addresses to add, edit, or set a default delivery address. You can also choose a different saved address at checkout.',
    },
    {
      'question': 'Is there a minimum order amount?',
      'answer':
          'No minimum order amount is required. Delivery fees may still apply depending on your distance from the restaurant.',
    },
    {
      'question': 'How do I delete my account?',
      'answer':
          'Please contact our support team using the options below and we\'ll process your account deletion request within 48 hours.',
    },
  ];

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
                    'Help & Support',
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

                    // ── Contact options ────────────────
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _contactCard(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: 'Live Chat',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Live chat coming soon')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _contactCard(
                            icon: Icons.phone_outlined,
                            label: 'Call Us',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('+92 300 1234567')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _contactCard(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('support@paradisecafe.com')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ── FAQ section ─────────────────────
                    Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.brown.shade100, width: 0.5),
                      ),
                      child: Column(
                        children: List.generate(_faqs.length, (index) {
                          final isExpanded = _expandedIndex == index;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _expandedIndex = isExpanded ? null : index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _faqs[index]['question']!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up_rounded
                                                : Icons.keyboard_arrow_down_rounded,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                      if (isExpanded) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          _faqs[index]['answer']!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            height: 1.5,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              if (index != _faqs.length - 1)
                                Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16, color: Colors.brown.shade100),
                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Business hours ─────────────────
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTint,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_rounded, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Support Hours',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Daily, 9:00 AM – 11:00 PM',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // ── Contact card helper widget ───────────────────
  Widget _contactCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.brown.shade100, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}