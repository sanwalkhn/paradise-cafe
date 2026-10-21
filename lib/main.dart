import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/splash/get_started_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/home/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/checkout/screens/checkout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ✅ replace with this
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: ParadiseCafeApp(),
    ),
  );
}

class ParadiseCafeApp extends StatelessWidget {
  const ParadiseCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradise Cafe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/getstarted': (context) => const GetStartedScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainScreen(),
 // ✅ replace with this
'/checkout': (context) => const CheckoutScreen(),
      },
    );
  }
}