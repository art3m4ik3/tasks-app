import 'package:flutter/material.dart';
import 'screens/settings_screen.dart';
import 'screens/home_screen.dart';
import 'screens/bin_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/bin':
        return MaterialPageRoute(builder: (_) => const BinScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
