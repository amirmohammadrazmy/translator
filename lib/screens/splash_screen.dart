import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:persian_translator/providers/app_provider.dart';
import 'package:persian_translator/screens/home_screen.dart';
import 'package:persian_translator/screens/update_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // شروع انیمیشن
    _animationController.forward();
    
    // انتظار برای اتمام انیمیشن
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      _checkForUpdates();
    }
  }

  Future<void> _checkForUpdates() async {
    try {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      final needsUpdate = await appProvider.checkForUpdates();
      
      if (mounted) {
        if (needsUpdate) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UpdateScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      // در صورت خطا، مستقیماً به صفحه اصلی بروید
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // دریافت اندازه صفحه
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final isLargeScreen = screenSize.width > 600;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          // محدود کردن اندازه انیمیشن برای گوشی‌های مختلف
          width: isSmallScreen 
              ? screenSize.width * 0.7  // گوشی‌های کوچک: 70% عرض صفحه
              : isLargeScreen 
                  ? 300  // تبلت/دسکتاپ: حداکثر 300px
                  : screenSize.width * 0.6,  // گوشی‌های معمولی: 60% عرض صفحه
          height: isSmallScreen 
              ? screenSize.height * 0.4  // گوشی‌های کوچک: 40% ارتفاع صفحه
              : isLargeScreen 
                  ? 300  // تبلت/دسکتاپ: حداکثر 300px
                  : screenSize.height * 0.5,  // گوشی‌های معمولی: 50% ارتفاع صفحه
          child: Lottie.asset(
            'assets/animations/splash_animation.json', // فایل Lottie شما
            controller: _animationController,
            onLoaded: (composition) {
              _animationController.duration = composition.duration;
            },
            repeat: false,
            fit: BoxFit.contain,
            // اضافه کردن error handling
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'خطا در بارگذاری انیمیشن',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[300],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 