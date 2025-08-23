# 📱 راهنمای کامل ساخت APK و انتشار اپلیکیشن

## 🎯 مراحل کلی

1. **تست**: اپلیکیشن را کاملاً تست کنید
2. **Build**: APK را با GitHub Actions بسازید
3. **Sign**: APK را امضا کنید (اختیاری)
4. **انتشار**: در Cafebazaar آپلود کنید

## 🚀 ساخت APK با GitHub Actions

### مرحله 1: فعال‌سازی Workflow

1. به repository خود در GitHub بروید
2. روی تب **Actions** کلیک کنید
3. روی **Flutter Build & Release** کلیک کنید
4. روی **Run workflow** کلیک کنید
5. نوع build را انتخاب کنید:
   - **Debug**: برای تست
   - **Release**: برای انتشار
   - **Bundle**: برای Google Play Store

### مرحله 2: انتظار برای Build

- Build حدود 10-15 دقیقه طول می‌کشد
- می‌توانید پیشرفت را در Actions tab مشاهده کنید
- در صورت خطا، logs را بررسی کنید

### مرحله 3: دانلود APK

#### از Artifacts:
1. در Actions tab، روی build کلیک کنید
2. در پایین صفحه، **Artifacts** را پیدا کنید
3. روی نام artifact کلیک کنید
4. APK دانلود می‌شود

#### از Releases:
1. اگر release build اجرا کردید، GitHub Release ایجاد می‌شود
2. در **Releases** tab، APK ها مستقیماً قابل دانلود هستند

## 🔐 امضای APK (اختیاری اما توصیه شده)

### مرحله 1: ایجاد Keystore

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### مرحله 2: تنظیم در Android

#### فایل `android/key.properties`:
```properties
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the keystore file, e.g., /Users/<user name>/upload-keystore.jks>
```

#### فایل `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            // ...
        }
    }
}
```

### مرحله 3: Build با Signing

```bash
flutter build apk --release
```

## 🏗️ ساخت APK محلی (اگر Android SDK دارید)

### مرحله 1: بررسی Flutter
```bash
flutter doctor
```

### مرحله 2: Build APK
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Profile APK (برای تست)
flutter build apk --profile
```

### مرحله 3: پیدا کردن APK
```
build/app/outputs/flutter-apk/
├── app-debug.apk
├── app-profile.apk
└── app-release.apk
```

## 📱 انتشار در Cafebazaar

### مرحله 1: آماده‌سازی

#### فایل‌های مورد نیاز:
- [ ] APK نهایی (app-release.apk)
- [ ] آیکون اپلیکیشن (512x512 px)
- [ ] تصاویر اسکرین‌شات (حداقل 2 عدد)
- [ ] توضیحات اپلیکیشن
- [ ] دسته‌بندی مناسب

### مرحله 2: ایجاد حساب توسعه‌دهنده

1. به [Cafebazaar Developer Console](https://cafebazaar.ir/developer) بروید
2. حساب کاربری ایجاد کنید
3. اطلاعات شخصی را تکمیل کنید
4. تایید هویت انجام دهید

### مرحله 3: آپلود اپلیکیشن

1. **اطلاعات پایه**:
   - نام اپلیکیشن: "مترجم هوشمند"
   - نام انگلیسی: "Smart Translator"
   - دسته‌بندی: "ابزارها" یا "آموزش"

2. **آپلود فایل‌ها**:
   - APK را آپلود کنید
   - آیکون و تصاویر را اضافه کنید

3. **توضیحات**:
   ```
   مترجم هوشمند - بهترین ابزار ترجمه و متن به گفتار
   
   ویژگی‌ها:
   ✅ ترجمه رایگان با API های معتبر
   ✅ تبدیل متن به گفتار (TTS)
   ✅ پشتیبانی از زبان فارسی و انگلیسی
   ✅ ذخیره تاریخچه ترجمه‌ها
   ✅ حالت تاریک و روشن
   ✅ طراحی زیبا و کاربرپسند
   
   قیمت: رایگان (با محدودیت 3 ترجمه در روز)
   اشتراک ماهانه: 30,000 تومان
   ```

4. **تنظیمات انتشار**:
   - قیمت: رایگان
   - دسترسی: عمومی
   - سن: همه سنین

### مرحله 4: بررسی و انتشار

1. **بررسی نهایی**:
   - تمام اطلاعات را بررسی کنید
   - تصاویر و توضیحات را چک کنید
   - APK را تست کنید

2. **ارسال برای بررسی**:
   - روی "ارسال برای بررسی" کلیک کنید
   - منتظر تایید Cafebazaar باشید

3. **انتشار**:
   - پس از تایید، اپلیکیشن منتشر می‌شود
   - در Cafebazaar قابل دانلود خواهد بود

## 🔄 به‌روزرسانی اپلیکیشن

### مرحله 1: تغییر نسخه

#### فایل `pubspec.yaml`:
```yaml
version: 1.0.1+2  # نسخه + build number
```

#### فایل `android/app/build.gradle`:
```gradle
android {
    defaultConfig {
        versionCode 2
        versionName "1.0.1"
    }
}
```

### مرحله 2: Build نسخه جدید

1. تغییرات را commit کنید
2. GitHub Actions workflow را اجرا کنید
3. APK جدید را دانلود کنید

### مرحله 3: آپلود نسخه جدید

1. در Cafebazaar Developer Console
2. روی اپلیکیشن کلیک کنید
3. "آپلود نسخه جدید" را انتخاب کنید
4. APK جدید را آپلود کنید
5. تغییرات را توضیح دهید

## 📊 نظارت بر عملکرد

### 1. آمار دانلود
- در Cafebazaar Developer Console
- تعداد دانلود روزانه/ماهانه
- رتبه در دسته‌بندی

### 2. بازخورد کاربران
- نظرات و امتیازات
- گزارش مشکلات
- پیشنهادات بهبود

### 3. عملکرد اپلیکیشن
- Crash reports
- Performance metrics
- User engagement

## 🚨 مشکلات رایج و راه‌حل‌ها

### مشکل: APK build نمی‌شود
**راه حل:**
1. `flutter clean` اجرا کنید
2. `flutter pub get` اجرا کنید
3. Logs را بررسی کنید
4. Dependencies را بررسی کنید

### مشکل: APK امضا نمی‌شود
**راه حل:**
1. فایل `key.properties` را بررسی کنید
2. مسیر keystore را چک کنید
3. رمزهای عبور را بررسی کنید

### مشکل: اپلیکیشن در Cafebazaar رد می‌شود
**راه حل:**
1. قوانین Cafebazaar را مطالعه کنید
2. محتوای نامناسب را حذف کنید
3. توضیحات را بهبود دهید
4. APK را تست کنید

## 📚 منابع مفید

- [Flutter Build Documentation](https://flutter.dev/docs/deployment/android)
- [Cafebazaar Developer Guidelines](https://developers.cafebazaar.ir/fa/guidelines/)
- [Android App Signing](https://developer.android.com/studio/publish/app-signing)
- [Flutter Release Checklist](https://flutter.dev/docs/deployment/android#release-checklist)

## 🎯 چک‌لیست نهایی

### قبل از Build:
- [ ] اپلیکیشن کاملاً تست شده
- [ ] تمام باگ‌ها رفع شده
- [ ] نسخه به‌روزرسانی شده
- [ ] فایل‌های assets آماده

### Build:
- [ ] GitHub Actions workflow اجرا شده
- [ ] APK با موفقیت ساخته شده
- [ ] APK دانلود شده
- [ ] APK تست شده

### انتشار:
- [ ] حساب Cafebazaar ایجاد شده
- [ ] اطلاعات اپلیکیشن تکمیل شده
- [ ] فایل‌ها آپلود شده
- [ ] برای بررسی ارسال شده

---

**🎉 تبریک! اپلیکیشن شما آماده انتشار در Cafebazaar است!** 