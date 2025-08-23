import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/translation_provider.dart';
import '../providers/subscription_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';
import '../widgets/daily_quote_card.dart';
import '../widgets/subscription_status_card.dart';
import 'history_screen.dart';
import 'favorites_screen.dart';
import 'paywall_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _selectedSourceLanguage = 'auto';
  String _selectedTargetLanguage = 'en';
  Translation? _currentTranslation;

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  Future<void> _translateText() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    final translationProvider = Provider.of<TranslationProvider>(context, listen: false);
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);

    // Check if user can translate
    final canTranslate = await subscriptionProvider.canUserTranslate();
    if (!canTranslate) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PaywallScreen()),
      );
      return;
    }

    // Perform translation
    final translation = await translationProvider.translateText(
      text: text,
      sourceLanguage: _selectedSourceLanguage,
      targetLanguage: _selectedTargetLanguage,
    );

    if (translation != null) {
      setState(() {
        _currentTranslation = translation;
        _outputController.text = translation.translatedText;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).translationSuccess),
          backgroundColor: AppTheme.accentColor,
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).translationFailed),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _selectedSourceLanguage;
      _selectedSourceLanguage = _selectedTargetLanguage;
      _selectedTargetLanguage = temp;
      
      // Clear output when swapping languages
      _outputController.clear();
      _currentTranslation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            ),
            tooltip: localizations.history,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
            tooltip: localizations.favorites,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
            tooltip: localizations.settings,
          ),
        ],
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Daily Quote Card
              const DailyQuoteCard(),
              
              const SizedBox(height: 20),
              
              // Subscription Status Card
              const SubscriptionStatusCard(),
              
              const SizedBox(height: 20),
              
              // Translation Interface
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Language Selection
                      Row(
                        children: [
                          Expanded(
                            child: _buildLanguageDropdown(
                              value: _selectedSourceLanguage,
                              onChanged: (value) {
                                setState(() {
                                  _selectedSourceLanguage = value ?? 'auto';
                                  _outputController.clear();
                                  _currentTranslation = null;
                                });
                              },
                              hint: 'Source Language',
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          IconButton(
                            onPressed: _swapLanguages,
                            icon: const Icon(Icons.swap_horiz),
                            tooltip: 'Swap Languages',
                          ),
                          
                          const SizedBox(width: 16),
                          
                          Expanded(
                            child: _buildLanguageDropdown(
                              value: _selectedTargetLanguage,
                              onChanged: (value) {
                                setState(() {
                                  _selectedTargetLanguage = value ?? 'en';
                                  _outputController.clear();
                                  _currentTranslation = null;
                                });
                              },
                              hint: 'Target Language',
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Input Text Field
                      TextField(
                        controller: _inputController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: localizations.inputHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          ),
                          filled: true,
                        ),
                        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Translate Button
                      Consumer<TranslationProvider>(
                        builder: (context, translationProvider, child) {
                          return ElevatedButton(
                            onPressed: translationProvider.isTranslating ? null : _translateText,
                            child: translationProvider.isTranslating
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(localizations.loading),
                                    ],
                                  )
                                : Text(localizations.translate),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Output Text Field
                      TextField(
                        controller: _outputController,
                        maxLines: 4,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: localizations.outputHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          ),
                          filled: true,
                        ),
                        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                      ),
                      
                      if (_currentTranslation != null) ...[
                        const SizedBox(height: 20),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: Consumer<TranslationProvider>(
                                builder: (context, translationProvider, child) {
                                  return ElevatedButton.icon(
                                    onPressed: () {
                                      translationProvider.playTTS(
                                        _currentTranslation!.translatedText,
                                        _selectedTargetLanguage,
                                      );
                                    },
                                    icon: Icon(
                                      translationProvider.isPlaying ? Icons.stop : Icons.volume_up,
                                    ),
                                    label: Text(
                                      translationProvider.isPlaying 
                                          ? localizations.ttsPlaying 
                                          : localizations.playAudio,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.secondaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            
                            const SizedBox(width: 12),
                            
                            Expanded(
                              child: Consumer<TranslationProvider>(
                                builder: (context, translationProvider, child) {
                                  return ElevatedButton.icon(
                                    onPressed: () {
                                      translationProvider.toggleFavorite(_currentTranslation!);
                                    },
                                    icon: Icon(
                                      _currentTranslation!.isFavorite 
                                          ? Icons.favorite 
                                          : Icons.favorite_border,
                                    ),
                                    label: Text(localizations.saveFavorite),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.accentColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<TranslationProvider>(context, listen: false)
                                      .copyToClipboard(_currentTranslation!.translatedText);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(localizations.textCopied),
                                      backgroundColor: AppTheme.accentColor,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy),
                                label: Text(localizations.copyText),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.warningColor,
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 12),
                            
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<TranslationProvider>(context, listen: false)
                                      .shareText(_currentTranslation!.translatedText);
                                },
                                icon: const Icon(Icons.share),
                                label: Text(localizations.shareText),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String value,
    required Function(String?) onChanged,
    required String hint,
  }) {
    final languages = [
      {'code': 'auto', 'name': 'Auto Detect'},
      {'code': 'fa', 'name': 'Persian'},
      {'code': 'en', 'name': 'English'},
      {'code': 'ar', 'name': 'Arabic'},
      {'code': 'tr', 'name': 'Turkish'},
      {'code': 'fr', 'name': 'French'},
      {'code': 'de', 'name': 'German'},
      {'code': 'es', 'name': 'Spanish'},
      {'code': 'it', 'name': 'Italian'},
      {'code': 'ru', 'name': 'Russian'},
      {'code': 'zh', 'name': 'Chinese'},
      {'code': 'ja', 'name': 'Japanese'},
      {'code': 'ko', 'name': 'Korean'},
    ];

    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        filled: true,
      ),
      items: languages.map((language) {
        return DropdownMenuItem<String>(
          value: language['code'],
          child: Text(language['name']!),
        );
      }).toList(),
    );
  }
} 