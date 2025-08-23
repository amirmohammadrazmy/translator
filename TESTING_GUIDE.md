# 🧪 راهنمای تست اپلیکیشن قبل از Build نهایی

## 🎯 چرا تست مهم است؟

تست اپلیکیشن قبل از build نهایی به شما کمک می‌کند:
- ✅ باگ‌ها را پیدا کنید
- ✅ عملکرد UI را بررسی کنید
- ✅ مشکلات عملکرد را شناسایی کنید
- ✅ تجربه کاربری را بهبود دهید

## 🚀 روش‌های تست بدون Android SDK

### روش 1: Flutter Web (توصیه شده)

#### مرحله 1: فعال‌سازی Web Support
```bash
flutter config --enable-web
flutter doctor
```

#### مرحله 2: اجرای اپلیکیشن در مرورگر
```bash
flutter run -d chrome
```

#### مزایا:
- ✅ سریع و آسان
- ✅ نیازی به دستگاه فیزیکی نیست
- ✅ تست UI و منطق برنامه
- ✅ رایگان و در دسترس

#### محدودیت‌ها:
- ❌ برخی ویژگی‌های native کار نمی‌کنند
- ❌ TTS ممکن است کار نکند
- ❌ SharedPreferences محدود است

### روش 2: Flutter Desktop

#### مرحله 1: فعال‌سازی Desktop Support
```bash
flutter config --enable-windows-desktop  # برای Windows
flutter config --enable-macos-desktop    # برای macOS
flutter config --enable-linux-desktop    # برای Linux
```

#### مرحله 2: اجرای اپلیکیشن
```bash
flutter run -d windows  # برای Windows
flutter run -d macos    # برای macOS
flutter run -d linux    # برای Linux
```

#### مزایا:
- ✅ عملکرد بهتر از Web
- ✅ تست کامل‌تر
- ✅ دسترسی به فایل سیستم

### روش 3: Flutter Inspector (Web)

#### مرحله 1: اجرای اپلیکیشن با Inspector
```bash
flutter run -d chrome --web-renderer html
```

#### مرحله 2: باز کردن Inspector
1. در مرورگر، روی آیکون Flutter کلیک کنید
2. Inspector باز می‌شود
3. می‌توانید UI را بررسی کنید

## 📱 تست کامل با دستگاه فیزیکی

### روش 1: Flutter App (مثل Expo)

#### مرحله 1: نصب Flutter App
1. در Google Play Store، "Flutter App" را جستجو کنید
2. نصب کنید
3. این app مثل Expo برای Flutter عمل می‌کند

#### مرحله 2: اتصال به کامپیوتر
```bash
flutter devices
flutter run
```

### روش 2: استفاده از دوست یا همکار

1. APK debug را بسازید
2. برای دوست خود ارسال کنید
3. بازخورد دریافت کنید

### روش 3: استفاده از سرویس‌های آنلاین

#### Appetize.io
- سرویس تست آنلاین
- شبیه‌سازی دستگاه‌های مختلف
- رایگان برای پروژه‌های کوچک

#### BrowserStack
- تست روی دستگاه‌های واقعی
- پشتیبانی از Flutter
- پولی اما حرفه‌ای

## 🧪 انواع تست

### 1. تست UI/UX
```dart
// تست رنگ‌ها و تم‌ها
void testTheme() {
  testWidgets('Theme switching works', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    
    // تست تغییر تم
    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pump();
    
    // بررسی تغییر رنگ
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
```

### 2. تست عملکرد
```dart
// تست ترجمه
void testTranslation() {
  testWidgets('Translation works', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    
    // وارد کردن متن
    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.pump();
    
    // کلیک روی دکمه ترجمه
    await tester.tap(find.text('ترجمه'));
    await tester.pump();
    
    // بررسی نتیجه
    expect(find.text('سلام'), findsOneWidget);
  });
}
```

### 3. تست State Management
```dart
// تست Provider
void testProvider() {
  test('AppProvider changes theme', () {
    final provider = AppProvider();
    
    expect(provider.themeMode, ThemeMode.system);
    
    provider.setThemeMode(ThemeMode.dark);
    expect(provider.themeMode, ThemeMode.dark);
  });
}
```

## 🔧 تست خودکار با GitHub Actions

### 1. تست در هر Commit
```yaml
# .github/workflows/test.yml
name: Flutter Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
    - run: flutter test
    - run: flutter analyze
```

### 2. تست UI
```yaml
- name: Run UI Tests
  run: |
    flutter drive --target=test_driver/app.dart
```

## 📋 چک‌لیست تست

### تست عمومی:
- [ ] اپلیکیشن بدون خطا اجرا می‌شود
- [ ] تمام صفحات بارگذاری می‌شوند
- [ ] ناوبری بین صفحات کار می‌کند
- [ ] دکمه‌ها پاسخ می‌دهند

### تست ترجمه:
- [ ] ورودی متن کار می‌کند
- [ ] ترجمه انجام می‌شود
- [ ] نتیجه نمایش داده می‌شود
- [ ] TTS کار می‌کند

### تست UI:
- [ ] رنگ‌ها درست نمایش داده می‌شوند
- [ ] فونت‌ها خوانا هستند
- [ ] RTL درست کار می‌کند
- [ ] انیمیشن‌ها نرم هستند

### تست عملکرد:
- [ ] سرعت بارگذاری مناسب است
- [ ] حافظه به درستی مدیریت می‌شود
- [ ] خطاها به درستی نمایش داده می‌شوند

## 🚨 مشکلات رایج و راه‌حل‌ها

### مشکل: اپلیکیشن در Web اجرا نمی‌شود
**راه حل:**
```bash
flutter clean
flutter pub get
flutter run -d chrome --web-renderer html
```

### مشکل: TTS کار نمیکند
**راه حل:**
```dart
// در web، از Web Speech API استفاده کنید
if (kIsWeb) {
  // استفاده از Web Speech API
} else {
  // استفاده از flutter_tts
}
```

### مشکل: SharedPreferences کار نمی‌کند
**راه حل:**
```dart
// برای web، از localStorage استفاده کنید
if (kIsWeb) {
  // استفاده از html.window.localStorage
} else {
  // استفاده از SharedPreferences
}
```

## 🎯 تست نهایی قبل از Build

### 1. تست کامل در Web
```bash
flutter run -d chrome
# تمام ویژگی‌ها را تست کنید
```

### 2. تست در Desktop (اگر ممکن است)
```bash
flutter run -d windows  # یا macos/linux
```

### 3. تست با Flutter App
```bash
flutter run
# در دستگاه فیزیکی یا شبیه‌ساز
```

### 4. تست عملکرد
```bash
flutter build apk --profile
# تست APK profile
```

## 📚 منابع مفید

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Flutter Web Support](https://flutter.dev/web)
- [Flutter Desktop Support](https://flutter.dev/desktop)
- [Flutter Inspector](https://flutter.dev/docs/development/tools/inspector)

## 🎉 نتیجه

با این روش‌ها می‌توانید اپلیکیشن خود را قبل از build نهایی کاملاً تست کنید:

1. **Web**: برای تست UI و منطق
2. **Desktop**: برای تست عملکرد
3. **Flutter App**: برای تست کامل
4. **GitHub Actions**: برای تست خودکار

---

**🧪 حالا می‌توانید اپلیکیشن خود را به طور کامل تست کنید!** 