import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const _localizedValues = {
    'en': {
      'app_name': 'Smart Translator',
      'translate': 'Translate',
      'input_hint': 'Enter text to translate...',
      'output_hint': 'Translation will appear here...',
      'play_audio': '🔊 Play',
      'save_favorite': '⭐ Save',
      'view_history': '📜 History',
      'favorites': 'Favorites',
      'history': 'History',
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'persian': 'Persian',
      'english': 'English',
      'copy_text': 'Copy Text',
      'share_text': 'Share Text',
      'text_copied': 'Text copied to clipboard',
      'text_shared': 'Text shared successfully',
      'daily_quotes': 'Daily Quotes',
      'subscription_required': 'Subscription Required',
      'free_limit_reached': 'You have reached your daily free limit',
      'subscribe_now': 'Subscribe Now',
      'subscription_price': '30,000 Toman per month',
      'subscription_description': 'Unlimited translations and premium features',
      'buy_from_bazaar': 'Buy from Bazaar',
      'update_required': 'Update Required',
      'update_description': 'A new version is available. Please update to continue using the app.',
      'update_now': 'Update Now',
      'translations_today': 'Translations today:',
      'remaining_free': 'Remaining free:',
      'unlimited': 'Unlimited',
      'error_occurred': 'An error occurred',
      'no_internet': 'No internet connection',
      'try_again': 'Try Again',
      'loading': 'Loading...',
      'no_history': 'No translation history',
      'no_favorites': 'No favorite translations',
      'clear_history': 'Clear History',
      'delete_favorite': 'Delete',
      'confirm_clear': 'Are you sure you want to clear all history?',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'translation_success': 'Translation completed successfully',
      'translation_failed': 'Translation failed. Please try again.',
      'tts_not_available': 'Text-to-speech not available',
      'tts_playing': 'Playing audio...',
      'tts_stopped': 'Audio stopped',
    },
    'fa': {
      'app_name': 'مترجم هوشمند',
      'translate': 'ترجمه',
      'input_hint': 'متن مورد نظر برای ترجمه را وارد کنید...',
      'output_hint': 'ترجمه اینجا نمایش داده می‌شود...',
      'play_audio': '🔊 پخش',
      'save_favorite': '⭐ ذخیره',
      'view_history': '📜 تاریخچه',
      'favorites': 'مورد علاقه',
      'history': 'تاریخچه',
      'settings': 'تنظیمات',
      'dark_mode': 'حالت تاریک',
      'language': 'زبان',
      'persian': 'فارسی',
      'english': 'انگلیسی',
      'copy_text': 'کپی متن',
      'share_text': 'اشتراک متن',
      'text_copied': 'متن در کلیپ‌بورد کپی شد',
      'text_shared': 'متن با موفقیت به اشتراک گذاشته شد',
      'daily_quotes': 'نقل قول روزانه',
      'subscription_required': 'اشتراک مورد نیاز',
      'free_limit_reached': 'شما به حد مجاز روزانه رسیده‌اید',
      'subscribe_now': 'اکنون مشترک شوید',
      'subscription_price': '۳۰,۰۰۰ تومان در ماه',
      'subscription_description': 'ترجمه نامحدود و ویژگی‌های ویژه',
      'buy_from_bazaar': 'خرید از بازار',
      'update_required': 'به‌روزرسانی مورد نیاز',
      'update_description': 'نسخه جدیدی موجود است. لطفاً برای ادامه استفاده از برنامه به‌روزرسانی کنید.',
      'update_now': 'اکنون به‌روزرسانی کنید',
      'translations_today': 'ترجمه‌های امروز:',
      'remaining_free': 'باقی‌مانده رایگان:',
      'unlimited': 'نامحدود',
      'error_occurred': 'خطایی رخ داد',
      'no_internet': 'اتصال اینترنت موجود نیست',
      'try_again': 'تلاش مجدد',
      'loading': 'در حال بارگذاری...',
      'no_history': 'تاریخچه ترجمه‌ای موجود نیست',
      'no_favorites': 'ترجمه مورد علاقه‌ای موجود نیست',
      'clear_history': 'پاک کردن تاریخچه',
      'delete_favorite': 'حذف',
      'confirm_clear': 'آیا مطمئن هستید که می‌خواهید تمام تاریخچه را پاک کنید؟',
      'cancel': 'لغو',
      'confirm': 'تایید',
      'translation_success': 'ترجمه با موفقیت انجام شد',
      'translation_failed': 'ترجمه ناموفق بود. لطفاً دوباره تلاش کنید.',
      'tts_not_available': 'تبدیل متن به گفتار در دسترس نیست',
      'tts_playing': 'در حال پخش صدا...',
      'tts_stopped': 'صدا متوقف شد',
    },
  };
  
  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get translate => _localizedValues[locale.languageCode]!['translate']!;
  String get inputHint => _localizedValues[locale.languageCode]!['input_hint']!;
  String get outputHint => _localizedValues[locale.languageCode]!['output_hint']!;
  String get playAudio => _localizedValues[locale.languageCode]!['play_audio']!;
  String get saveFavorite => _localizedValues[locale.languageCode]!['save_favorite']!;
  String get viewHistory => _localizedValues[locale.languageCode]!['view_history']!;
  String get favorites => _localizedValues[locale.languageCode]!['favorites']!;
  String get history => _localizedValues[locale.languageCode]!['history']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get darkMode => _localizedValues[locale.languageCode]!['dark_mode']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get persian => _localizedValues[locale.languageCode]!['persian']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get copyText => _localizedValues[locale.languageCode]!['copy_text']!;
  String get shareText => _localizedValues[locale.languageCode]!['share_text']!;
  String get textCopied => _localizedValues[locale.languageCode]!['text_copied']!;
  String get textShared => _localizedValues[locale.languageCode]!['text_shared']!;
  String get dailyQuotes => _localizedValues[locale.languageCode]!['daily_quotes']!;
  String get subscriptionRequired => _localizedValues[locale.languageCode]!['subscription_required']!;
  String get freeLimitReached => _localizedValues[locale.languageCode]!['free_limit_reached']!;
  String get subscribeNow => _localizedValues[locale.languageCode]!['subscribe_now']!;
  String get subscriptionPrice => _localizedValues[locale.languageCode]!['subscription_price']!;
  String get subscriptionDescription => _localizedValues[locale.languageCode]!['subscription_description']!;
  String get buyFromBazaar => _localizedValues[locale.languageCode]!['buy_from_bazaar']!;
  String get updateRequired => _localizedValues[locale.languageCode]!['update_required']!;
  String get updateDescription => _localizedValues[locale.languageCode]!['update_description']!;
  String get updateNow => _localizedValues[locale.languageCode]!['update_now']!;
  String get translationsToday => _localizedValues[locale.languageCode]!['translations_today']!;
  String get remainingFree => _localizedValues[locale.languageCode]!['remaining_free']!;
  String get unlimited => _localizedValues[locale.languageCode]!['unlimited']!;
  String get errorOccurred => _localizedValues[locale.languageCode]!['error_occurred']!;
  String get noInternet => _localizedValues[locale.languageCode]!['no_internet']!;
  String get tryAgain => _localizedValues[locale.languageCode]!['try_again']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get noHistory => _localizedValues[locale.languageCode]!['no_history']!;
  String get noFavorites => _localizedValues[locale.languageCode]!['no_favorites']!;
  String get clearHistory => _localizedValues[locale.languageCode]!['clear_history']!;
  String get deleteFavorite => _localizedValues[locale.languageCode]!['delete_favorite']!;
  String get confirmClear => _localizedValues[locale.languageCode]!['confirm_clear']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;
  String get translationSuccess => _localizedValues[locale.languageCode]!['translation_success']!;
  String get translationFailed => _localizedValues[locale.languageCode]!['translation_failed']!;
  String get ttsNotAvailable => _localizedValues[locale.languageCode]!['tts_not_available']!;
  String get ttsPlaying => _localizedValues[locale.languageCode]!['tts_playing']!;
  String get ttsStopped => _localizedValues[locale.languageCode]!['tts_stopped']!;
  
  // Date formatting
  String formatDate(DateTime date) {
    if (locale.languageCode == 'fa') {
      return DateFormat.yMMMd('fa_IR').format(date);
    }
    return DateFormat.yMMMd('en_US').format(date);
  }
  
  // Number formatting
  String formatNumber(int number) {
    if (locale.languageCode == 'fa') {
      return NumberFormat.decimalPattern('fa_IR').format(number);
    }
    return NumberFormat.decimalPattern('en_US').format(number);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
} 