import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subscription_provider.dart';
import '../utils/constants.dart';

class SubscriptionStatusCard extends StatelessWidget {
  const SubscriptionStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, subscriptionProvider, child) {
        return FutureBuilder<String>(
          future: subscriptionProvider.getSubscriptionStatusText(),
          builder: (context, snapshot) {
            final statusText = snapshot.data ?? 'Loading...';
            
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  gradient: LinearGradient(
                    colors: subscriptionProvider.isSubscribed 
                        ? AppTheme.primaryGradient 
                        : [Colors.grey.shade300, Colors.grey.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Row(
                  children: [
                    Icon(
                      subscriptionProvider.isSubscribed 
                          ? Icons.verified 
                          : Icons.info_outline,
                      color: subscriptionProvider.isSubscribed 
                          ? Colors.white 
                          : Colors.grey.shade700,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subscriptionProvider.isSubscribed 
                                ? 'اشتراک فعال'
                                : 'حساب رایگان',
                            style: TextStyle(
                              color: subscriptionProvider.isSubscribed 
                                  ? Colors.white 
                                  : Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Vazir',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: subscriptionProvider.isSubscribed 
                                  ? Colors.white.withOpacity(0.9) 
                                  : Colors.grey.shade600,
                              fontSize: 14,
                              fontFamily: 'Vazir',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!subscriptionProvider.isSubscribed)
                      IconButton(
                        onPressed: () {
                          // Navigate to paywall
                          Navigator.of(context).pushNamed('/paywall');
                        },
                        icon: Icon(
                          Icons.upgrade,
                          color: Colors.grey.shade700,
                        ),
                        tooltip: 'Upgrade to Premium',
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
} 