import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import '../models/translation.dart';
import '../utils/constants.dart';

class TranslationProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  
  List<Translation> _translationHistory = [];
  List<Translation> _favorites = [];
  bool _isTranslating = false;
  bool _isPlaying = false;
  String _errorMessage = '';
  int _dailyTranslationCount = 0;
  DateTime? _lastTranslationDate;

  // Getters
  List<Translation> get translationHistory => _translationHistory;
  List<Translation> get favorites => _favorites;
  bool get isTranslating => _isTranslating;
  bool get isPlaying => _isPlaying;
  String get errorMessage => _errorMessage;
  int get dailyTranslationCount => _dailyTranslationCount;
  DateTime? get lastTranslationDate => _lastTranslationDate;
  int get remainingFreeTranslations => AppConstants.freeDailyTranslations - _dailyTranslationCount;

  // Initialize the provider
  Future<void> initialize() async {
    await _loadData();
    await _initializeTTS();
    await _resetDailyCountIfNeeded();
  }

  // Initialize TTS
  Future<void> _initializeTTS() async {
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
    } catch (e) {
      _errorMessage = 'Failed to initialize TTS: $e';
      notifyListeners();
    }
  }

  // Load saved data
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load translation history
      final historyJson = prefs.getString(AppConstants.keyTranslationHistory);
      if (historyJson != null) {
        final historyList = json.decode(historyJson) as List;
        _translationHistory = historyList
            .map((item) => Translation.fromJson(item))
            .toList();
      }
      
      // Load favorites
      final favoritesJson = prefs.getString(AppConstants.keyFavorites);
      if (favoritesJson != null) {
        final favoritesList = json.decode(favoritesJson) as List;
        _favorites = favoritesList
            .map((item) => Translation.fromJson(item))
            .toList();
      }
      
      // Load daily count
      _dailyTranslationCount = prefs.getInt(AppConstants.keyDailyTranslationCount) ?? 0;
      
      // Load last translation date
      final lastDateString = prefs.getString(AppConstants.keyLastTranslationDate);
      if (lastDateString != null) {
        _lastTranslationDate = DateTime.parse(lastDateString);
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
      notifyListeners();
    }
  }

  // Save data
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save translation history
      final historyJson = json.encode(
        _translationHistory.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(AppConstants.keyTranslationHistory, historyJson);
      
      // Save favorites
      final favoritesJson = json.encode(
        _favorites.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(AppConstants.keyFavorites, favoritesJson);
      
      // Save daily count
      await prefs.setInt(AppConstants.keyDailyTranslationCount, _dailyTranslationCount);
      
      // Save last translation date
      if (_lastTranslationDate != null) {
        await prefs.setString(
          AppConstants.keyLastTranslationDate,
          _lastTranslationDate!.toIso8601String(),
        );
      }
    } catch (e) {
      _errorMessage = 'Failed to save data: $e';
      notifyListeners();
    }
  }

  // Reset daily count if it's a new day
  Future<void> _resetDailyCountIfNeeded() async {
    final now = DateTime.now();
    if (_lastTranslationDate == null || 
        !_isSameDay(_lastTranslationDate!, now)) {
      _dailyTranslationCount = 0;
      _lastTranslationDate = now;
      await _saveData();
    }
  }

  // Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  // Translate text
  Future<Translation?> translateText({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    if (text.trim().isEmpty) return null;
    
    try {
      _isTranslating = true;
      _errorMessage = '';
      notifyListeners();

      // Check daily limit (this will be handled by subscription provider)
      if (_dailyTranslationCount >= AppConstants.freeDailyTranslations) {
        throw Exception('Daily free limit reached');
      }

      // Make API call
      final response = await http.post(
        Uri.parse(AppConstants.translationApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': text,
          'source': sourceLanguage,
          'target': targetLanguage,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final translatedText = data['translatedText'] ?? '';
        
        if (translatedText.isNotEmpty) {
          // Create translation object
          final translation = Translation.create(
            originalText: text,
            translatedText: translatedText,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
          );
          
          // Add to history
          _addToHistory(translation);
          
          // Increment daily count
          _dailyTranslationCount++;
          _lastTranslationDate = DateTime.now();
          await _saveData();
          
          return translation;
        } else {
          throw Exception('Empty translation response');
        }
      } else {
        throw Exception('Translation failed: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Translation failed: $e';
      notifyListeners();
      return null;
    } finally {
      _isTranslating = false;
      notifyListeners();
    }
  }

  // Add translation to history
  void _addToHistory(Translation translation) {
    _translationHistory.insert(0, translation);
    
    // Keep only the last N items
    if (_translationHistory.length > AppConstants.maxHistoryItems) {
      _translationHistory = _translationHistory.take(AppConstants.maxHistoryItems).toList();
    }
    
    _saveData();
  }

  // Toggle favorite status
  Future<void> toggleFavorite(Translation translation) async {
    final updatedTranslation = translation.copyWith(isFavorite: !translation.isFavorite);
    
    if (updatedTranslation.isFavorite) {
      // Add to favorites
      if (!_favorites.any((item) => item.id == translation.id)) {
        _favorites.add(updatedTranslation);
      }
    } else {
      // Remove from favorites
      _favorites.removeWhere((item) => item.id == translation.id);
    }
    
    // Update in history
    final historyIndex = _translationHistory.indexWhere((item) => item.id == translation.id);
    if (historyIndex != -1) {
      _translationHistory[historyIndex] = updatedTranslation;
    }
    
    await _saveData();
    notifyListeners();
  }

  // Play TTS
  Future<void> playTTS(String text, String language) async {
    try {
      if (_isPlaying) {
        await _flutterTts.stop();
        _isPlaying = false;
      } else {
        // Set language for TTS
        if (language == 'fa') {
          await _flutterTts.setLanguage('fa-IR');
        } else {
          await _flutterTts.setLanguage('en-US');
        }
        
        await _flutterTts.speak(text);
        _isPlaying = true;
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'TTS failed: $e';
      notifyListeners();
    }
  }

  // Stop TTS
  Future<void> stopTTS() async {
    try {
      await _flutterTts.stop();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to stop TTS: $e';
      notifyListeners();
    }
  }

  // Copy text to clipboard
  Future<void> copyToClipboard(String text) async {
    try {
      await FlutterClipboard.copy(text);
      // Show success message (handled by UI)
    } catch (e) {
      _errorMessage = 'Failed to copy text: $e';
      notifyListeners();
    }
  }

  // Share text
  Future<void> shareText(String text) async {
    try {
      await Share.share(text);
    } catch (e) {
      _errorMessage = 'Failed to share text: $e';
      notifyListeners();
    }
  }

  // Clear history
  Future<void> clearHistory() async {
    _translationHistory.clear();
    await _saveData();
    notifyListeners();
  }

  // Delete favorite
  Future<void> deleteFavorite(String id) async {
    _favorites.removeWhere((item) => item.id == id);
    
    // Update in history
    final historyIndex = _translationHistory.indexWhere((item) => item.id == id);
    if (historyIndex != -1) {
      _translationHistory[historyIndex] = _translationHistory[historyIndex].copyWith(isFavorite: false);
    }
    
    await _saveData();
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Get translations for today
  List<Translation> getTodayTranslations() {
    final today = DateTime.now();
    return _translationHistory.where((translation) {
      return _isSameDay(translation.timestamp, today);
    }).toList();
  }

  // Dispose
  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
} 