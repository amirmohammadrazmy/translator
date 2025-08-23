import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppTheme.primaryGradient,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Update Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.system_update,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Title
                  Text(
                    localizations.updateRequired,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Vazir',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Description
                  Text(
                    localizations.updateDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Vazir',
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Version Info
                  Consumer<AppProvider>(
                    builder: (context, appProvider, child) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'نسخه فعلی: ${AppConstants.appVersion}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Vazir',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'نسخه جدید: ${appProvider.latestVersion}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Update Button
                  SizedBox(
                    width: double.infinity,
                    height: AppConstants.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () => _openBazaarForUpdate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.download),
                          const SizedBox(width: 12),
                          Text(
                            localizations.updateNow,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Vazir',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Alternative Update Link
                  Consumer<AppProvider>(
                    builder: (context, appProvider, child) {
                      return TextButton(
                        onPressed: () => _openBazaarForUpdate(context),
                        child: Text(
                          'یا کلیک کنید برای باز کردن بازار',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Vazir',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Features in New Version
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'ویژگی‌های جدید در نسخه ${context.read<AppProvider>().latestVersion}:',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Vazir',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureItem('بهبود عملکرد ترجمه', Icons.speed),
                        _buildFeatureItem('رابط کاربری بهتر', Icons.palette),
                        _buildFeatureItem('پشتیبانی از زبان‌های بیشتر', Icons.language),
                        _buildFeatureItem('رفع مشکلات امنیتی', Icons.security),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Footer Note
                  Text(
                    'برای استفاده از تمام ویژگی‌ها، لطفاً برنامه را به‌روزرسانی کنید.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontFamily: 'Vazir',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Vazir',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openBazaarForUpdate(BuildContext context) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    
    try {
      final url = Uri.parse(appProvider.updateUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to default Bazaar URL
        final fallbackUrl = Uri.parse(AppConstants.bazaarAppUrl);
        if (await canLaunchUrl(fallbackUrl)) {
          await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Could not open Bazaar app');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در باز کردن بازار: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 