# 🌐 راهنمای تست آنلاین اپلیکیشن Flutter (بدون نیاز به سیستم قوی)

## 🎯 چرا تست آنلاین؟

- ✅ **بدون نیاز به سیستم قوی**
- ✅ **بدون دانلود Android SDK**
- ✅ **تست سریع و آسان**
- ✅ **دسترسی از هر جا**

## 🚀 روش 1: Flutter Web (توصیه شده)

### مرحله 1: فعال‌سازی Web Support
```bash
flutter config --enable-web
flutter doctor
```

### مرحله 2: اجرای اپلیکیشن
```bash
flutter run -d chrome
```

### مزایا:
- 🎯 **سریع**: اجرا در چند ثانیه
- 💻 **ساده**: فقط مرورگر نیاز است
- 🔄 **Real-time**: تغییرات فوری نمایش داده می‌شود
- 📱 **Responsive**: تست در اندازه‌های مختلف

### محدودیت‌ها:
- ❌ TTS کامل کار نمی‌کند
- ❌ برخی ویژگی‌های native محدود است
- ❌ SharedPreferences محدود است

## 🌐 روش 2: سایت‌های آنلاین تست

### 1. **FlutterFlow (رایگان)**
- **آدرس**: [flutterflow.io](https://flutterflow.io)
- **ویژگی‌ها**:
  - تست UI و انیمیشن‌ها
  - شبیه‌سازی دستگاه‌های مختلف
  - رایگان برای پروژه‌های کوچک

### 2. **DartPad (رایگان)**
- **آدرس**: [dartpad.dev](https://dartpad.dev)
- **ویژگی‌ها**:
  - تست کدهای ساده
  - اجرای فوری
  - مناسب برای تست منطق

### 3. **CodePen Flutter (رایگان)**
- **آدرس**: [codepen.io](https://codepen.io)
- **ویژگی‌ها**:
  - تست UI components
  - اشتراک‌گذاری کد
  - جامعه فعال

## 📱 روش 3: تست با دستگاه فیزیکی (بدون شبیه‌ساز)

### 1. **Flutter App (مثل Expo)**
```bash
# نصب Flutter App از Google Play
# اتصال به کامپیوتر
flutter devices
flutter run
```

### 2. **استفاده از دوست/همکار**
1. APK debug بسازید
2. برای دوست ارسال کنید
3. بازخورد دریافت کنید

## 🧪 روش 4: تست خودکار با GitHub Actions

### 1. **تست در هر Commit**
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

### 2. **تست UI**
```yaml
- name: Run UI Tests
  run: |
    flutter drive --target=test_driver/app.dart
```

## 🔧 راه‌اندازی تست آنلاین

### مرحله 1: آماده‌سازی پروژه
```bash
# در پوشه پروژه
flutter clean
flutter pub get
```

### مرحله 2: تست Web
```bash
flutter run -d chrome --web-renderer html
```

### مرحله 3: تست Desktop (اگر ممکن است)
```bash
flutter run -d windows  # یا macos/linux
```

## 📋 چک‌لیست تست آنلاین

### تست UI/UX:
- [ ] رنگ‌ها درست نمایش داده می‌شوند
- [ ] فونت‌ها خوانا هستند
- [ ] RTL درست کار می‌کند
- [ ] انیمیشن‌ها نرم هستند
- [ ] Responsive design کار می‌کند

### تست عملکرد:
- [ ] سرعت بارگذاری مناسب است
- [ ] ناوبری بین صفحات کار می‌کند
- [ ] دکمه‌ها پاسخ می‌دهند
- [ ] فرم‌ها کار می‌کنند

### تست ترجمه:
- [ ] ورودی متن کار می‌کند
- [ ] ترجمه انجام می‌شود
- [ ] نتیجه نمایش داده می‌شود
- [ ] تاریخچه ذخیره می‌شود

## 🚨 مشکلات رایج و راه‌حل‌ها

### مشکل: اپلیکیشن در Web اجرا نمی‌شود
**راه حل:**
```bash
flutter clean
flutter pub get
flutter run -d chrome --web-renderer html
```

### مشکل: TTS کار نمی‌کند
**راه حل:**
```dart
// در web، از Web Speech API استفاده کنید
if (kIsWeb) {
  // استفاده از Web Speech API
  // یا غیرفعال کردن TTS در web
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
# در دستگاه فیزیکی
```

### 4. تست عملکرد
```bash
flutter build apk --profile
# تست APK profile
```

## 📚 منابع مفید

### Flutter Web:
- [Flutter Web Documentation](https://flutter.dev/web)
- [Flutter Web Performance](https://flutter.dev/docs/development/tools/web-performance)

### تست آنلاین:
- [FlutterFlow](https://flutterflow.io)
- [DartPad](https://dartpad.dev)
- [CodePen Flutter](https://codepen.io)

### تست خودکار:
- [Flutter Testing](https://flutter.dev/docs/testing)
- [GitHub Actions](https://docs.github.com/en/actions)

## 🎉 نتیجه

با این روش‌ها می‌توانید اپلیکیشن خود را کاملاً تست کنید:

1. **Web**: برای تست UI و منطق
2. **سایت‌های آنلاین**: برای تست سریع
3. **دستگاه فیزیکی**: برای تست کامل
4. **GitHub Actions**: برای تست خودکار

---

**🧪 حالا می‌توانید اپلیکیشن خود را بدون نیاز به سیستم قوی تست کنید!**
