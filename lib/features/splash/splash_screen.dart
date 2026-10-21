import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/theme/app_colors.dart';
import '../../core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

   Timer(const Duration(seconds: 5), () {
  if (mounted) {
    final authService = AuthService();
    if (authService.currentUser != null) {
      // already logged in — skip straight to Home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // not logged in — show onboarding
      Navigator.pushReplacementNamed(context, '/getstarted');
    }
  }
});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(                          // ← CHANGED: was just Scaffold with backgroundColor
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),  // ← your bg image
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: AppColors.darkBrown.withOpacity(0.55),  // ← dark overlay on top of bg
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Logo image
                    Image.asset(
                      'assets/images/logo.png',
                      width: 220,
                      height: 220,
                    ),

                    const SizedBox(height: 16),

                    // Restaurant name
                    Text(
                      'Paradise',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gold,
                        letterSpacing: 2,
                      ),
                    ),

                    Text(
                      'CAFE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 8,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'in every bite',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Loading indicator
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 2.5,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}