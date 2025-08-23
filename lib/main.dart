import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:persian_translator/providers/app_provider.dart';
import 'package:persian_translator/providers/translation_provider.dart';
import 'package:persian_translator/providers/subscription_provider.dart';
import 'package:persian_translator/screens/splash_screen.dart';
import 'package:persian_translator/utils/constants.dart';
import 'package:persian_translator/utils/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize providers
  final appProvider = AppProvider();
  final translationProvider = TranslationProvider();
  final subscriptionProvider = SubscriptionProvider();
  
  // Load initial data
  await appProvider.initialize();
  await subscriptionProvider.initialize();
  
  runApp(MyApp(
    appProvider: appProvider,
    translationProvider: translationProvider,
    subscriptionProvider: subscriptionProvider,
  ));
}

class MyApp extends StatelessWidget {
  final AppProvider appProvider;
  final TranslationProvider translationProvider;
  final SubscriptionProvider subscriptionProvider;

  const MyApp({
    Key? key,
    required this.appProvider,
    required this.translationProvider,
    required this.subscriptionProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appProvider),
        ChangeNotifierProvider.value(value: translationProvider),
        ChangeNotifierProvider.value(value: subscriptionProvider),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            title: 'مترجم هوشمند',
            debugShowCheckedModeBanner: false,
            
            // Localization
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fa', 'IR'), // Persian
              Locale('en', 'US'), // English
            ],
            locale: appProvider.currentLocale,
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appProvider.themeMode,
            
            // Routes
            home: const SplashScreen(),
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
} 