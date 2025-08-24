import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/subscription.dart';
import '../utils/constants.dart';

class SubscriptionProvider extends ChangeNotifier {
  Subscription _subscription = Subscription.free();
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  Subscription get subscription => _subscription;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSubscribed => _subscription.isActive;
  bool get canTranslate => isSubscribed; // Will be updated dynamically

  // Initialize the provider
  Future<void> initialize() async {
    await _loadSubscription();
  }

  // Load subscription from storage
  Future<void> _loadSubscription() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subscriptionJson = prefs.getString(AppConstants.keySubscriptionStatus);
      
      if (subscriptionJson != null) {
        final data = json.decode(subscriptionJson);
        _subscription = Subscription.fromJson(data);
        
        // Check if subscription is expired
        if (_subscription.isExpired) {
          _subscription = _subscription.copyWith(status: SubscriptionStatus.expired);
          await _saveSubscription();
        }
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load subscription: $e';
      notifyListeners();
    }
  }

  // Save subscription to storage
  Future<void> _saveSubscription() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subscriptionJson = json.encode(_subscription.toJson());
      await prefs.setString(AppConstants.keySubscriptionStatus, subscriptionJson);
    } catch (e) {
      _errorMessage = 'Failed to save subscription: $e';
      notifyListeners();
    }
  }

  // Get remaining free translations for today
  Future<int> _getRemainingFreeTranslations() async {
    if (isSubscribed) return AppConstants.freeDailyTranslations; // Unlimited for subscribers
    
    final prefs = await SharedPreferences.getInstance();
    final dailyCount = prefs.getInt(AppConstants.keyDailyTranslationCount) ?? 0;
    final lastDateString = prefs.getString(AppConstants.keyLastTranslationDate);
    
    if (lastDateString != null) {
      final lastDate = DateTime.parse(lastDateString);
      final now = DateTime.now();
      
      // Reset count if it's a new day
      if (lastDate.year != now.year || 
          lastDate.month != now.month || 
          lastDate.day != now.day) {
        return AppConstants.freeDailyTranslations;
      }
    }
    
    return AppConstants.freeDailyTranslations - dailyCount;
  }

  // Purchase subscription (placeholder for Bazaar integration)
  Future<bool> purchaseSubscription() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      // TODO: Implement actual Bazaar billing
      // For now, simulate a successful purchase
      await Future.delayed(const Duration(seconds: 2));
      
      // Create subscription for 1 month
      final now = DateTime.now();
      final endDate = DateTime(now.year, now.month + 1, now.day);
      
      _subscription = Subscription.create(
        startDate: now,
        endDate: endDate,
        transactionId: 'simulated_${now.millisecondsSinceEpoch}',
        bazaarToken: 'simulated_token',
      );
      
      await _saveSubscription();
      
      return true;
    } catch (e) {
      _errorMessage = 'Purchase failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Restore subscription (placeholder for Bazaar integration)
  Future<bool> restoreSubscription() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      // TODO: Implement actual Bazaar restore
      // For now, just return false
      await Future.delayed(const Duration(seconds: 1));
      
      return false;
    } catch (e) {
      _errorMessage = 'Restore failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Open Bazaar app for purchase
  Future<void> openBazaarForPurchase() async {
    try {
      final url = Uri.parse(AppConstants.bazaarAppUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _errorMessage = 'Could not open Bazaar app';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to open Bazaar: $e';
      notifyListeners();
    }
  }

  // Check if user can translate (considering subscription and daily limit)
  Future<bool> canUserTranslate() async {
    if (isSubscribed) return true;
    
    final remaining = await _getRemainingFreeTranslations();
    return remaining > 0;
  }

  // Get subscription status text
  Future<String> getSubscriptionStatusText() async {
    if (isSubscribed) {
      return 'اشتراک فعال - ${_subscription.remainingDays} روز باقی‌مانده';
    } else if (_subscription.status == SubscriptionStatus.expired) {
      return 'اشتراک منقضی شده';
    } else {
      final remaining = await _getRemainingFreeTranslations();
      return 'رایگان - $remaining ترجمه باقی‌مانده';
    }
  }

  // Get subscription price text
  String getSubscriptionPriceText() {
    return '${AppConstants.subscriptionPrice} ${AppConstants.subscriptionCurrency} ${AppConstants.subscriptionPeriod}';
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Simulate subscription expiration (for testing)
  Future<void> simulateExpiration() async {
    if (_subscription.status == SubscriptionStatus.subscribed) {
      final expiredDate = DateTime.now().subtract(const Duration(days: 1));
      _subscription = _subscription.copyWith(
        status: SubscriptionStatus.expired,
        endDate: expiredDate,
      );
      await _saveSubscription();
      notifyListeners();
    }
  }

  // Reset subscription to free (for testing)
  Future<void> resetToFree() async {
    _subscription = Subscription.free();
    await _saveSubscription();
    notifyListeners();
  }
} 