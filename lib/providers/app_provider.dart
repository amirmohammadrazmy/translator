import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _currentLocale = const Locale('fa', 'IR');
  bool _isLoading = false;
  String _errorMessage = '';
  bool _updateRequired = false;
  String _latestVersion = '';
  String _updateUrl = '';

  // Getters
  ThemeMode get themeMode => _themeMode;
  Locale get currentLocale => _currentLocale;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get updateRequired => _updateRequired;
  String get latestVersion => _latestVersion;
  String get updateUrl => _updateUrl;

  // Initialize the app
  Future<void> initialize() async {
    await _loadSettings();
    await _checkForUpdates();
  }

  // Load saved settings
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load theme mode
      final themeModeIndex = prefs.getInt(AppConstants.keyThemeMode) ?? 0;
      _themeMode = ThemeMode.values[themeModeIndex];
      
      // Load language
      final languageCode = prefs.getString(AppConstants.keyLanguage) ?? 'fa';
      _currentLocale = Locale(languageCode, languageCode == 'fa' ? 'IR' : 'US');
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load settings: $e';
      notifyListeners();
    }
  }

  // Save settings
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save theme mode
      await prefs.setInt(AppConstants.keyThemeMode, _themeMode.index);
      
      // Save language
      await prefs.setString(AppConstants.keyLanguage, _currentLocale.languageCode);
    } catch (e) {
      _errorMessage = 'Failed to save settings: $e';
      notifyListeners();
    }
  }

  // Check for app updates
  Future<void> _checkForUpdates() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(AppConstants.versionCheckUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _latestVersion = data['latest_version'] ?? '';
        _updateUrl = data['update_url'] ?? AppConstants.bazaarAppUrl;
        
        // Compare versions (simple string comparison for now)
        if (_latestVersion.isNotEmpty && _latestVersion != AppConstants.appVersion) {
          _updateRequired = true;
        }
      }
    } catch (e) {
      _errorMessage = 'Failed to check for updates: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveSettings();
      notifyListeners();
    }
  }

  // Toggle theme mode
  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case ThemeMode.light:
        await setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.system:
        await setThemeMode(ThemeMode.light);
        break;
    }
  }

  // Set language
  Future<void> setLanguage(String languageCode) async {
    final newLocale = Locale(languageCode, languageCode == 'fa' ? 'IR' : 'US');
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      await _saveSettings();
      notifyListeners();
    }
  }

  // Toggle language
  Future<void> toggleLanguage() async {
    if (_currentLocale.languageCode == 'fa') {
      await setLanguage('en');
    } else {
      await setLanguage('fa');
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Reset update requirement (after user updates)
  void resetUpdateRequirement() {
    _updateRequired = false;
    notifyListeners();
  }

  // Get current language name
  String getCurrentLanguageName() {
    return _currentLocale.languageCode == 'fa' ? 'فارسی' : 'English';
  }

  // Check if current language is RTL
  bool get isRTL => _currentLocale.languageCode == 'fa';

  // Get theme name
  String getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
} 