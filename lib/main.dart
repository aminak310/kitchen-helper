import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'navigation/main_navigation.dart';

void main() {
  runApp(const KitchenHelperApp());
}

class KitchenHelperApp extends StatelessWidget {
  const KitchenHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Helper',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}
