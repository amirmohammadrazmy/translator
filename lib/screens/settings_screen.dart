import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/subscription_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    children: [
                      // App Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.translate,
                          size: 40,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // App Name
                      Text(
                        localizations.appName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // App Version
                      Text(
                        'نسخه ${AppConstants.appVersion}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // App Description
                      Text(
                        'مترجم هوشمند با قابلیت تبدیل متن به گفتار و پشتیبانی از زبان‌های مختلف',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontFamily: 'Vazir',
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Subscription Status
              Consumer<SubscriptionProvider>(
                builder: (context, subscriptionProvider, child) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'وضعیت اشتراک',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Vazir',
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          FutureBuilder<String>(
                            future: subscriptionProvider.getSubscriptionStatusText(),
                            builder: (context, snapshot) {
                              final statusText = snapshot.data ?? 'در حال بارگذاری...';
                              
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: subscriptionProvider.isSubscribed 
                                      ? AppTheme.primaryColor.withOpacity(0.1)
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: subscriptionProvider.isSubscribed 
                                        ? AppTheme.primaryColor.withOpacity(0.3)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      subscriptionProvider.isSubscribed 
                                          ? Icons.verified 
                                          : Icons.info_outline,
                                      color: subscriptionProvider.isSubscribed 
                                          ? AppTheme.primaryColor 
                                          : Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        statusText,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Vazir',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          
                          if (!subscriptionProvider.isSubscribed) ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/paywall');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'ارتقا به نسخه ویژه',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Vazir',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 20),
              
              // Appearance Settings
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ظاهر برنامه',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Theme Mode
                      Consumer<AppProvider>(
                        builder: (context, appProvider, child) {
                          return ListTile(
                            leading: const Icon(Icons.palette),
                            title: Text(
                              localizations.darkMode,
                              style: const TextStyle(fontFamily: 'Vazir'),
                            ),
                            subtitle: Text(
                              appProvider.getThemeName(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: 'Vazir',
                              ),
                            ),
                            trailing: Switch(
                              value: appProvider.themeMode == ThemeMode.dark,
                              onChanged: (value) {
                                appProvider.setThemeMode(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                            ),
                            onTap: () {
                              appProvider.toggleTheme();
                            },
                          );
                        },
                      ),
                      
                      const Divider(),
                      
                      // Language Selection
                      Consumer<AppProvider>(
                        builder: (context, appProvider, child) {
                          return ListTile(
                            leading: const Icon(Icons.language),
                            title: Text(
                              localizations.language,
                              style: const TextStyle(fontFamily: 'Vazir'),
                            ),
                            subtitle: Text(
                              appProvider.getCurrentLanguageName(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: 'Vazir',
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              appProvider.toggleLanguage();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // App Features
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ویژگی‌های برنامه',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildFeatureItem('ترجمه متن', Icons.translate, 'پشتیبانی از زبان‌های مختلف'),
                      _buildFeatureItem('تبدیل متن به گفتار', Icons.volume_up, 'پخش صوتی ترجمه‌ها'),
                      _buildFeatureItem('ذخیره علاقه‌ها', Icons.favorite, 'ذخیره ترجمه‌های مهم'),
                      _buildFeatureItem('تاریخچه ترجمه', Icons.history, 'دسترسی به ترجمه‌های قبلی'),
                      _buildFeatureItem('جستجو', Icons.search, 'جستجو در تاریخچه و علاقه‌ها'),
                      _buildFeatureItem('اشتراک گذاری', Icons.share, 'اشتراک ترجمه‌ها با دیگران'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Support & Contact
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'پشتیبانی و تماس',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      ListTile(
                        leading: const Icon(Icons.help_outline),
                        title: const Text(
                          'راهنمای استفاده',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Show help guide
                        },
                      ),
                      
                      const Divider(),
                      
                      ListTile(
                        leading: const Icon(Icons.bug_report),
                        title: const Text(
                          'گزارش مشکل',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Report bug
                        },
                      ),
                      
                      const Divider(),
                      
                      ListTile(
                        leading: const Icon(Icons.feedback),
                        title: const Text(
                          'ارسال نظرات',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Send feedback
                        },
                      ),
                      
                      const Divider(),
                      
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text(
                          'درباره برنامه',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Legal
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'قوانین و مقررات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      ListTile(
                        leading: const Icon(Icons.description),
                        title: const Text(
                          'قوانین استفاده',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Show terms
                        },
                      ),
                      
                      const Divider(),
                      
                      ListTile(
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text(
                          'حریم خصوصی',
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Show privacy policy
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Vazir',
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontFamily: 'Vazir',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppLocalizations.of(context).appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.translate,
          size: 32,
          color: AppTheme.primaryColor,
        ),
      ),
      children: [
        const SizedBox(height: 16),
        Text(
          'مترجم هوشمند یک برنامه کاربردی برای ترجمه متن و تبدیل متن به گفتار است.',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Vazir',
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '© 2024 مترجم هوشمند. تمامی حقوق محفوظ است.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontFamily: 'Vazir',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 