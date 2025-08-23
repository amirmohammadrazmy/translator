import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subscription_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isRTL = localizations.locale.languageCode == 'fa';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.subscriptionRequired),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Header Icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    Icons.star,
                    size: 60,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Title
              Text(
                localizations.subscriptionRequired,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Vazir',
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Description
              Text(
                localizations.freeLimitReached,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontFamily: 'Vazir',
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Subscription Plan Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    gradient: LinearGradient(
                      colors: AppTheme.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    children: [
                      // Plan Name
                      Text(
                        'اشتراک ماهانه',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppConstants.subscriptionPrice,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Vazir',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppConstants.subscriptionCurrency,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Vazir',
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        AppConstants.subscriptionPeriod,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Features List
                      _buildFeatureItem('ترجمه نامحدود', Icons.translate),
                      _buildFeatureItem('تبدیل متن به گفتار', Icons.volume_up),
                      _buildFeatureItem('بدون تبلیغات', Icons.block),
                      _buildFeatureItem('پشتیبانی ۲۴/۷', Icons.support_agent),
                      
                      const SizedBox(height: 30),
                      
                      // Subscribe Button
                      Consumer<SubscriptionProvider>(
                        builder: (context, subscriptionProvider, child) {
                          return SizedBox(
                            width: double.infinity,
                            height: AppConstants.buttonHeight,
                            child: ElevatedButton(
                              onPressed: subscriptionProvider.isLoading 
                                  ? null 
                                  : () => _handleSubscription(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                ),
                              ),
                              child: subscriptionProvider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                    )
                                  : Text(
                                      localizations.subscribeNow,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Vazir',
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Alternative Options
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        'گزینه‌های دیگر',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Restore Purchase Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _handleRestorePurchase(context),
                          icon: const Icon(Icons.restore),
                          label: const Text('بازیابی خرید'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Terms and Privacy
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Show terms
                            },
                            child: const Text('قوانین و مقررات'),
                          ),
                          Text(
                            'و',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              // Show privacy policy
                            },
                            child: const Text('حریم خصوصی'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Footer Note
              Text(
                'اشتراک شما به صورت خودکار تمدید می‌شود مگر اینکه قبل از پایان دوره آن را لغو کنید.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontFamily: 'Vazir',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Vazir',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubscription(BuildContext context) async {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    
    try {
      final success = await subscriptionProvider.purchaseSubscription();
      
      if (success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('اشتراک با موفقیت فعال شد!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(subscriptionProvider.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در خرید اشتراک: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleRestorePurchase(BuildContext context) async {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    
    try {
      final success = await subscriptionProvider.restoreSubscription();
      
      if (success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('اشتراک با موفقیت بازیابی شد!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('اشتراکی برای بازیابی یافت نشد.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در بازیابی: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 