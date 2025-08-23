import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/translation_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';
import '../models/translation.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.favorites),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: Consumer<TranslationProvider>(
          builder: (context, translationProvider, child) {
            final favorites = translationProvider.favorites;
            
            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.noFavorites,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ترجمه‌های مورد علاقه خود را ذخیره کنید تا بعداً به راحتی به آن‌ها دسترسی داشته باشید.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontFamily: 'Vazir',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final translation = favorites[index];
                return _buildFavoriteItem(translation, translationProvider);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(Translation translation, TranslationProvider translationProvider) {
    final isRTL = translation.sourceLanguage == 'fa' || translation.targetLanguage == 'fa';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with languages and favorite icon
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildLanguageChip(translation.sourceLanguage, 'از'),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 16),
                        const SizedBox(width: 8),
                        _buildLanguageChip(translation.targetLanguage, 'به'),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.pink.shade600,
                    size: 24,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Original Text
              Text(
                'متن اصلی:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontFamily: 'Vazir',
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  translation.originalText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Vazir',
                  ),
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Translated Text
              Text(
                'ترجمه:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontFamily: 'Vazir',
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  translation.translatedText,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.primaryColor.shade700,
                    fontFamily: 'Vazir',
                  ),
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        translationProvider.playTTS(
                          translation.translatedText,
                          translation.targetLanguage,
                        );
                      },
                      icon: Icon(
                        translationProvider.isPlaying ? Icons.stop : Icons.volume_up,
                      ),
                      label: Text(
                        translationProvider.isPlaying ? 'توقف' : 'پخش',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        translationProvider.toggleFavorite(translation);
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text('حذف از علاقه'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade600,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        translationProvider.copyToClipboard(translation.translatedText);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context).textCopied),
                            backgroundColor: AppTheme.accentColor,
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: Text(AppLocalizations.of(context).copyText),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        translationProvider.shareText(translation.translatedText);
                      },
                      icon: const Icon(Icons.share),
                      label: Text(AppLocalizations.of(context).shareText),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Timestamp
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ذخیره شده در: ${_formatTimestamp(translation.timestamp)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String languageCode, String prefix) {
    final languageNames = {
      'auto': 'خودکار',
      'fa': 'فارسی',
      'en': 'انگلیسی',
      'ar': 'عربی',
      'tr': 'ترکی',
      'fr': 'فرانسوی',
      'de': 'آلمانی',
      'es': 'اسپانیایی',
      'it': 'ایتالیایی',
      'ru': 'روسی',
      'zh': 'چینی',
      'ja': 'ژاپنی',
      'ko': 'کره‌ای',
    };
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade300),
      ),
      child: Text(
        '$prefix ${languageNames[languageCode] ?? languageCode}',
        style: TextStyle(
          fontSize: 12,
          color: Colors.pink.shade700,
          fontFamily: 'Vazir',
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} روز پیش';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعت پیش';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقیقه پیش';
    } else {
      return 'همین الان';
    }
  }
} 