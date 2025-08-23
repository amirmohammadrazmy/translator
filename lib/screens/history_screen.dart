import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/translation_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';
import '../models/translation.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Translation> _filteredHistory = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterHistory);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterHistory() {
    final searchTerm = _searchController.text.toLowerCase();
    final translationProvider = Provider.of<TranslationProvider>(context, listen: false);
    
    if (searchTerm.isEmpty) {
      setState(() {
        _filteredHistory = translationProvider.translationHistory;
        _isSearching = false;
      });
    } else {
      setState(() {
        _filteredHistory = translationProvider.translationHistory.where((translation) {
          return translation.originalText.toLowerCase().contains(searchTerm) ||
                 translation.translatedText.toLowerCase().contains(searchTerm);
        }).toList();
        _isSearching = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.history),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _showClearHistoryDialog,
            tooltip: localizations.clearHistory,
          ),
        ],
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'جستجو در تاریخچه...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                  filled: true,
                ),
              ),
            ),
            
            // History List
            Expanded(
              child: Consumer<TranslationProvider>(
                builder: (context, translationProvider, child) {
                  final history = _isSearching ? _filteredHistory : translationProvider.translationHistory;
                  
                  if (history.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isSearching ? Icons.search_off : Icons.history,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isSearching ? 'نتیجه‌ای یافت نشد' : localizations.noHistory,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontFamily: 'Vazir',
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final translation = history[index];
                      return _buildHistoryItem(translation, translationProvider);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Translation translation, TranslationProvider translationProvider) {
    final isRTL = translation.sourceLanguage == 'fa' || translation.targetLanguage == 'fa';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with languages and timestamp
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
                Text(
                  _formatTimestamp(translation.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
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
                color: Colors.grey.shade50,
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
                    icon: Icon(
                      translation.isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      translation.isFavorite ? 'حذف از علاقه' : 'افزودن به علاقه',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
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
                          content: Text(localizations.textCopied),
                          backgroundColor: AppTheme.accentColor,
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(localizations.copyText),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      translationProvider.shareText(translation.translatedText);
                    },
                    icon: const Icon(Icons.share),
                    label: Text(localizations.shareText),
                  ),
                ),
              ],
            ),
          ],
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
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Text(
        '$prefix ${languageNames[languageCode] ?? languageCode}',
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.primaryColor.shade700,
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

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('پاک کردن تاریخچه'),
        content: const Text('آیا مطمئن هستید که می‌خواهید تمام تاریخچه را پاک کنید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('لغو'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<TranslationProvider>(context, listen: false).clearHistory();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تاریخچه پاک شد'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('پاک کردن'),
          ),
        ],
      ),
    );
  }
} 