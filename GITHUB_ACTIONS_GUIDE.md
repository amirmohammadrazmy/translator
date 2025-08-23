# 🚀 راهنمای کامل ساخت اپلیکیشن با GitHub Actions

## 📋 پیش‌نیازها

### 1. حساب GitHub
- یک حساب GitHub داشته باشید
- پروژه Flutter خود را در GitHub آپلود کنید

### 2. ساختار پروژه
پروژه شما باید شامل این فایل‌ها باشد:
```
your-project/
├── .github/
│   └── workflows/
│       └── flutter_build.yml
├── lib/
├── android/
├── pubspec.yaml
└── README.md
```

## 🛠️ مراحل راه‌اندازی

### مرحله 1: آپلود پروژه به GitHub

```bash
# در پوشه پروژه Flutter خود
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

### مرحله 2: فعال‌سازی GitHub Actions

1. به repository خود در GitHub بروید
2. روی تب **Actions** کلیک کنید
3. روی **Configure** کلیک کنید
4. فایل `flutter_build.yml` که ایجاد کردیم را کپی کنید

### مرحله 3: اجرای اولین Build

1. در GitHub repository، روی **Actions** کلیک کنید
2. روی **Flutter Build & Release** کلیک کنید
3. روی **Run workflow** کلیک کنید
4. نوع build را انتخاب کنید:
   - **Debug**: برای تست
   - **Release**: برای انتشار
   - **Bundle**: برای Google Play Store

## 📱 انواع Build

### Debug APK
- برای تست و توسعه
- حجم کمتر
- قابل نصب مستقیم

### Release APK
- برای انتشار نهایی
- بهینه‌سازی شده
- قابل آپلود در Cafebazaar

### App Bundle (.aab)
- برای Google Play Store
- حجم کمتر
- بهینه‌سازی بهتر

## 🔄 فرآیند Build

### 1. خودکار (Automatic)
- هر بار که کد را push کنید
- Build خودکار اجرا می‌شود
- نتایج در Actions tab قابل مشاهده است

### 2. دستی (Manual)
- در Actions tab روی **Run workflow** کلیک کنید
- نوع build را انتخاب کنید
- Build شروع می‌شود

## 📥 دانلود نتایج

### 1. Artifacts
- در Actions tab، روی build مورد نظر کلیک کنید
- در پایین صفحه، **Artifacts** را پیدا کنید
- روی نام artifact کلیک کنید تا دانلود شود

### 2. Releases
- اگر release build اجرا کنید، GitHub Release ایجاد می‌شود
- در **Releases** tab قابل مشاهده است
- APK ها مستقیماً قابل دانلود هستند

## ⚡ مزایای GitHub Actions

✅ **بدون نیاز به Android SDK محلی**
✅ **Build سریع و قابل اعتماد**
✅ **Cache کردن dependencies**
✅ **Build برای تمام پلتفرم‌ها**
✅ **اتوماسیون کامل**
✅ **رایگان برای پروژه‌های عمومی**

## 🚨 نکات مهم

### 1. محدودیت‌های GitHub
- **Public repositories**: 2000 دقیقه در ماه رایگان
- **Private repositories**: 3000 دقیقه در ماه رایگان
- هر build حدود 10-15 دقیقه زمان می‌برد

### 2. بهینه‌سازی
- از cache استفاده کنید
- فقط فایل‌های ضروری را commit کنید
- از `.gitignore` مناسب استفاده کنید

### 3. امنیت
- کلیدهای signing را در GitHub Secrets ذخیره کنید
- از environment variables استفاده کنید

## 🔧 تنظیمات پیشرفته

### 1. Signing APK
```yaml
- name: Setup signing
  uses: r0adkll/sign-android-release@v1
  with:
    releaseDirectory: build/app/outputs/flutter-apk
    signingKeyBase64: ${{ secrets.SIGNING_KEY }}
    alias: ${{ secrets.KEY_ALIAS }}
    keyStorePassword: ${{ secrets.KEY_STORE_PASSWORD }}
    keyPassword: ${{ secrets.KEY_PASSWORD }}
```

### 2. Build Matrix
```yaml
strategy:
  matrix:
    target: [arm64, arm, x64]
    build_type: [debug, release]
```

### 3. Conditional Build
```yaml
- name: Build APK
  if: matrix.build_type == 'release'
  run: flutter build apk --release --target-platform android-${{ matrix.target }}
```

## 📞 پشتیبانی

اگر مشکلی داشتید:
1. **Actions logs** را بررسی کنید
2. **GitHub Issues** ایجاد کنید
3. **Stack Overflow** جستجو کنید
4. **Flutter Discord** کمک بگیرید

## 🎯 مراحل بعدی

1. **تست**: Debug APK را دانلود و تست کنید
2. **بهینه‌سازی**: کد را بهبود دهید
3. **انتشار**: Release APK را در Cafebazaar آپلود کنید
4. **نظارت**: عملکرد app را بررسی کنید

---

**🎉 تبریک! حالا می‌توانید بدون Android SDK، اپلیکیشن Flutter خود را بسازید!** 