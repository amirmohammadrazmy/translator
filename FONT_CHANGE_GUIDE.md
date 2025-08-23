# 🎨 راهنمای تغییر فونت در اپلیکیشن Flutter

## 📚 فونت‌های فعلی

اپلیکیشن شما در حال حاضر از فونت **Vazir** استفاده می‌کند که برای زبان فارسی بهینه‌سازی شده است.

## 🔧 مراحل تغییر فونت

### مرحله 1: دانلود فونت جدید

1. فونت مورد نظر خود را دانلود کنید (فرمت‌های پشتیبانی شده: `.ttf`, `.otf`)
2. فونت را در پوشه `assets/fonts/` قرار دهید

### مرحله 2: ویرایش pubspec.yaml

فایل `pubspec.yaml` را باز کنید و در بخش `fonts` تغییرات زیر را اعمال کنید:

```yaml
flutter:
  fonts:
    - family: Vazir
      fonts:
        - asset: assets/fonts/Vazir.ttf
        - asset: assets/fonts/Vazir-Bold.ttf
          weight: 700
        - asset: assets/fonts/Vazir-Light.ttf
          weight: 300
          
    # فونت جدید خود را اینجا اضافه کنید
    - family: YourNewFont
      fonts:
        - asset: assets/fonts/YourNewFont-Regular.ttf
        - asset: assets/fonts/YourNewFont-Bold.ttf
          weight: 700
        - asset: assets/fonts/YourNewFont-Light.ttf
          weight: 300
```

### مرحله 3: ویرایش فایل constants.dart

فایل `lib/utils/constants.dart` را باز کنید و فونت جدید را اضافه کنید:

```dart
class AppTheme {
  // فونت‌های موجود
  static const String primaryFont = 'Vazir';
  static const String secondaryFont = 'YourNewFont'; // فونت جدید
  
  // تعریف تم‌ها با فونت جدید
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: primaryFont, // یا secondaryFont
      // ... سایر تنظیمات
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: primaryFont, // یا secondaryFont
      // ... سایر تنظیمات
    );
  }
}
```

### مرحله 4: اعمال تغییرات

```bash
flutter clean
flutter pub get
```

## 🎯 مثال‌های عملی

### مثال 1: تغییر به فونت فارسی دیگر

```yaml
# pubspec.yaml
fonts:
  - family: IRANSans
    fonts:
      - asset: assets/fonts/IRANSans.ttf
      - asset: assets/fonts/IRANSans-Bold.ttf
        weight: 700
```

```dart
// constants.dart
static const String primaryFont = 'IRANSans';
```

### مثال 2: استفاده از فونت انگلیسی

```yaml
# pubspec.yaml
fonts:
  - family: Roboto
    fonts:
      - asset: assets/fonts/Roboto-Regular.ttf
      - asset: assets/fonts/Roboto-Bold.ttf
        weight: 700
```

```dart
// constants.dart
static const String primaryFont = 'Roboto';
```

### مثال 3: فونت‌های متعدد

```yaml
# pubspec.yaml
fonts:
  - family: Vazir
    fonts:
      - asset: assets/fonts/Vazir.ttf
  - family: IRANSans
    fonts:
      - asset: assets/fonts/IRANSans.ttf
  - family: Roboto
    fonts:
      - asset: assets/fonts/Roboto-Regular.ttf
```

```dart
// constants.dart
class AppTheme {
  static const String persianFont = 'Vazir';
  static const String englishFont = 'Roboto';
  
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: persianFont,
      // ...
    );
  }
}
```

## 🔄 تغییر فونت در زمان اجرا

### 1. اضافه کردن متغیر در AppProvider

```dart
// lib/providers/app_provider.dart
class AppProvider with ChangeNotifier {
  String _currentFont = 'Vazir';
  
  String get currentFont => _currentFont;
  
  void setFont(String fontFamily) {
    _currentFont = fontFamily;
    _saveFontPreference();
    notifyListeners();
  }
  
  Future<void> _saveFontPreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_font', _currentFont);
  }
  
  Future<void> _loadFontPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _currentFont = prefs.getString('selected_font') ?? 'Vazir';
  }
}
```

### 2. اعمال فونت در MaterialApp

```dart
// lib/main.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme.copyWith(
            fontFamily: appProvider.currentFont,
          ),
          darkTheme: AppTheme.darkTheme.copyWith(
            fontFamily: appProvider.currentFont,
          ),
          // ...
        );
      },
    );
  }
}
```

### 3. اضافه کردن گزینه تغییر فونت در Settings

```dart
// lib/screens/settings_screen.dart
Widget _buildFontSettings() {
  return Consumer<AppProvider>(
    builder: (context, appProvider, child) {
      return Card(
        child: ListTile(
          title: Text('انتخاب فونت'),
          subtitle: Text(appProvider.currentFont),
          trailing: DropdownButton<String>(
            value: appProvider.currentFont,
            items: [
              DropdownMenuItem(value: 'Vazir', child: Text('Vazir')),
              DropdownMenuItem(value: 'IRANSans', child: Text('IRANSans')),
              DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
            ],
            onChanged: (value) {
              if (value != null) {
                appProvider.setFont(value);
              }
            },
          ),
        ),
      );
    },
  );
}
```

## 📱 فونت‌های پیشنهادی برای فارسی

### فونت‌های فارسی محبوب:
1. **Vazir** - مدرن و خوانا
2. **IRANSans** - رسمی و حرفه‌ای
3. **B Nazanin** - کلاسیک و زیبا
4. **B Titr** - عناوین و هدرها
5. **B Yekan** - مدرن و ساده

### فونت‌های انگلیسی:
1. **Roboto** - رسمی و خوانا
2. **Open Sans** - مدرن و زیبا
3. **Lato** - حرفه‌ای و شیک
4. **Poppins** - مدرن و جذاب

## ⚠️ نکات مهم

### 1. حجم فونت
- فونت‌های فارسی معمولاً حجم بالایی دارند
- از فونت‌های بهینه‌سازی شده استفاده کنید
- فونت‌های غیرضروری را حذف کنید

### 2. سازگاری
- فونت باید از کاراکترهای فارسی پشتیبانی کند
- از فونت‌های استاندارد استفاده کنید
- تست کنید که همه کاراکترها نمایش داده شوند

### 3. عملکرد
- فونت‌های اضافی سرعت app را کاهش می‌دهند
- فقط فونت‌های مورد نیاز را اضافه کنید
- از cache کردن فونت‌ها استفاده کنید

## 🔍 عیب‌یابی

### مشکل: فونت نمایش داده نمی‌شود
**راه حل:**
1. مسیر فایل فونت را بررسی کنید
2. `flutter clean` و `flutter pub get` اجرا کنید
3. نام فونت را در `pubspec.yaml` بررسی کنید

### مشکل: فونت در برخی دستگاه‌ها کار نمی‌کند
**راه حل:**
1. از فونت‌های استاندارد استفاده کنید
2. فونت‌های fallback اضافه کنید
3. تست در دستگاه‌های مختلف

### مشکل: حجم APK زیاد شده
**راه حل:**
1. فونت‌های غیرضروری را حذف کنید
2. از فونت‌های بهینه‌سازی شده استفاده کنید
3. فونت‌ها را در پوشه جداگانه قرار دهید

## 📚 منابع مفید

- [Flutter Fonts Documentation](https://flutter.dev/docs/cookbook/design/fonts)
- [Google Fonts](https://fonts.google.com/)
- [Font Awesome](https://fontawesome.com/)
- [Persian Fonts Collection](https://github.com/aminabedi68/PersianFonts)

---

**🎨 حالا می‌توانید فونت اپلیکیشن خود را به راحتی تغییر دهید!** 