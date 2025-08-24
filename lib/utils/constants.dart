import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/paywall_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/update_screen.dart';

class AppConstants {
  // App Info
  static const String appName = 'مترجم هوشمند';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String translationApiUrl = 'https://libretranslate.de/translate';
  static const String versionCheckUrl = 'https://yourusername.github.io/persian-translator/version.json';
  
  // Translation Limits
  static const int freeDailyTranslations = 3;
  static const int maxHistoryItems = 20;
  
  // Subscription
  static const String subscriptionPrice = '30,000';
  static const String subscriptionCurrency = 'تومان';
  static const String subscriptionPeriod = 'ماهانه';
  
  // Bazaar App ID
  static const String bazaarAppId = 'ir.behtarinarts.dikshenery';
  static const String bazaarAppUrl = 'https://cafebazaar.ir/app/$bazaarAppId';
  
  // Local Storage Keys
  static const String keyTranslationHistory = 'translation_history';
  static const String keyFavorites = 'favorites';
  static const String keySubscriptionStatus = 'subscription_status';
  static const String keyDailyTranslationCount = 'daily_translation_count';
  static const String keyLastTranslationDate = 'last_translation_date';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  
  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double buttonHeight = 56.0;
}

class AppTheme {
  // Persian-inspired color palette
  static const MaterialColor primaryColor = Colors.blue;    // Blue
  static const Color secondaryColor = Color(0xFFFF6B35);    // Orange
  static const Color accentColor = Color(0xFF4CAF50);       // Green
  static const Color warningColor = Color(0xFFFF9800);      // Amber
  static const Color errorColor = Color(0xFFF44336);        // Red
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Colors.blue,
    Colors.lightBlueAccent,
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFF6B35),
    Color(0xFFFF8A65),
  ];
  
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lightText,
      ),
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightText,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: lightSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        filled: true,
        fillColor: lightSurface,
      ),
      fontFamily: 'Vazir',
    );
  }
  
  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkText,
      ),
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
          minimumSize: const Size(double.infinity, AppConstants.buttonHeight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        filled: true,
        fillColor: darkSurface,
      ),
      fontFamily: 'Vazir',
    );
  }
}

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String history = '/history';
  static const String favorites = '/favorites';
  static const String paywall = '/paywall';
  static const String update = '/update';
  static const String settings = '/settings';
  
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    history: (context) => const HistoryScreen(),
    favorites: (context) => const FavoritesScreen(),
    paywall: (context) => const PaywallScreen(),
    update: (context) => const UpdateScreen(),
    settings: (context) => const SettingsScreen(),
  };
} 