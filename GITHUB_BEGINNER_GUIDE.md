# 🌟 راهنمای کامل شروع کار با GitHub برای تازه‌کاران

## 🎯 GitHub چیست؟

GitHub یک پلتفرم برای ذخیره، مدیریت و همکاری روی کدهای برنامه‌نویسی است. مثل یک "Google Drive" برای کدها!

## 📋 پیش‌نیازها

### 1. نصب Git
- [Git برای Windows](https://git-scm.com/download/win)
- [Git برای macOS](https://git-scm.com/download/mac)
- [Git برای Linux](https://git-scm.com/download/linux)

### 2. ایجاد حساب GitHub
1. به [github.com](https://github.com) بروید
2. روی **Sign up** کلیک کنید
3. ایمیل، رمز عبور و نام کاربری انتخاب کنید
4. حساب خود را تایید کنید

## 🚀 مراحل اولیه

### مرحله 1: تنظیم Git محلی

#### تنظیم نام و ایمیل:
```bash
git config --global user.name "نام شما"
git config --global user.email "ایمیل شما"
```

#### بررسی تنظیمات:
```bash
git config --list
```

### مرحله 2: ایجاد Repository جدید

#### در GitHub:
1. روی **+** کلیک کنید
2. **New repository** را انتخاب کنید
3. نام repository را وارد کنید: `my-flutter-app`
4. **Public** یا **Private** انتخاب کنید
5. **Create repository** کلیک کنید

#### در کامپیوتر:
```bash
# ایجاد پوشه پروژه
mkdir my-flutter-app
cd my-flutter-app

# راه‌اندازی Git
git init

# اتصال به GitHub
git remote add origin https://github.com/YOUR_USERNAME/my-flutter-app.git
```

## 📁 مفاهیم اصلی Git

### 1. Working Directory
پوشه‌ای که در آن کار می‌کنید (مثل `my-flutter-app`)

### 2. Staging Area
محلی برای آماده‌سازی فایل‌ها قبل از commit

### 3. Repository
محلی که تمام تغییرات ذخیره می‌شود

## 🔄 دستورات اصلی Git

### 1. بررسی وضعیت
```bash
git status
```
نشان می‌دهد کدام فایل‌ها تغییر کرده‌اند

### 2. اضافه کردن فایل‌ها
```bash
# اضافه کردن همه فایل‌ها
git add .

# اضافه کردن فایل خاص
git add filename.txt
```

### 3. ثبت تغییرات (Commit)
```bash
git commit -m "توضیح تغییرات"
```

### 4. ارسال به GitHub
```bash
git push origin main
```

### 5. دریافت تغییرات
```bash
git pull origin main
```

## 📱 کار با پروژه Flutter

### مرحله 1: آپلود پروژه موجود

```bash
# در پوشه پروژه Flutter
git init
git add .
git commit -m "Initial commit: Flutter translation app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/my-flutter-app.git
git push -u origin main
```

### مرحله 2: ساختار پروژه
```
my-flutter-app/
├── .github/
│   └── workflows/
│       └── flutter_build.yml
├── lib/
│   ├── main.dart
│   ├── providers/
│   ├── screens/
│   └── widgets/
├── android/
├── assets/
├── pubspec.yaml
└── README.md
```

### مرحله 3: فایل .gitignore
```gitignore
# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/

# Android
android/app/debug
android/app/profile
android/app/release

# IDE
.vscode/
.idea/
*.iml

# OS
.DS_Store
Thumbs.db
```

## 🔄 کار روزانه با Git

### 1. شروع روز
```bash
git pull origin main
```

### 2. کار روی کد
- فایل‌ها را ویرایش کنید
- کد جدید بنویسید
- باگ‌ها را رفع کنید

### 3. ذخیره تغییرات
```bash
git add .
git commit -m "Add new feature: dark mode toggle"
git push origin main
```

### 4. بررسی تاریخچه
```bash
git log --oneline
```

## 🌿 کار با Branch ها

### 1. ایجاد Branch جدید
```bash
git checkout -b feature/new-feature
```

### 2. تغییر بین Branch ها
```bash
git checkout main
git checkout feature/new-feature
```

### 3. ادغام Branch
```bash
git checkout main
git merge feature/new-feature
git branch -d feature/new-feature
```

## 🚀 GitHub Actions

### 1. فعال‌سازی Actions
1. در repository، روی **Actions** کلیک کنید
2. روی **Configure** کلیک کنید
3. فایل workflow را کپی کنید

### 2. اجرای Actions
1. روی **Run workflow** کلیک کنید
2. نوع build را انتخاب کنید
3. منتظر اتمام build باشید

### 3. مشاهده نتایج
- در **Actions** tab
- دانلود APK از **Artifacts**
- مشاهده **Releases**

## 📊 مدیریت پروژه

### 1. Issues (مشکلات)
- برای گزارش باگ‌ها
- برای درخواست ویژگی‌های جدید
- برای سوالات

### 2. Projects (پروژه‌ها)
- مدیریت وظایف
- برنامه‌ریزی
- پیگیری پیشرفت

### 3. Wiki
- مستندات
- راهنماها
- مثال‌ها

## 🔧 حل مشکلات رایج

### مشکل: "Permission denied"
**راه حل:**
```bash
git remote set-url origin https://YOUR_USERNAME@github.com/YOUR_USERNAME/repo-name.git
```

### مشکل: "Merge conflict"
**راه حل:**
1. فایل‌های conflict را باز کنید
2. خطوط مشکل‌دار را حل کنید
3. `git add .` و `git commit` اجرا کنید

### مشکل: "Branch ahead/behind"
**راه حل:**
```bash
git pull origin main
git push origin main
```

## 📚 منابع یادگیری

### 1. مستندات رسمی
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Flutter Documentation](https://flutter.dev/docs)

### 2. دوره‌های آنلاین
- [GitHub Learning Lab](https://lab.github.com/)
- [Udemy Git Courses](https://www.udemy.com/topic/git/)
- [YouTube Git Tutorials](https://www.youtube.com/results?search_query=git+tutorial)

### 3. کتاب‌ها
- "Pro Git" (رایگان)
- "Git for Humans"
- "Git Pocket Guide"

## 🎯 پروژه‌های تمرینی

### 1. پروژه ساده
- ایجاد repository
- اضافه کردن فایل README
- تغییر و commit کردن

### 2. پروژه متوسط
- کار با branch ها
- حل conflict
- استفاده از Issues

### 3. پروژه پیشرفته
- GitHub Actions
- Collaboration
- Code review

## 🤝 همکاری با دیگران

### 1. Fork کردن
- کپی کردن repository دیگران
- تغییرات خود را اعمال کنید
- Pull Request ارسال کنید

### 2. Pull Request
- پیشنهاد تغییرات
- Code review
- ادغام کد

### 3. Code Review
- بررسی کد دیگران
- ارائه نظرات
- تایید تغییرات

## 🔒 امنیت

### 1. کلیدهای SSH
```bash
# ایجاد کلید SSH
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# اضافه کردن به GitHub
# Settings > SSH and GPG keys
```

### 2. Personal Access Token
- برای API access
- محدود کردن دسترسی
- تاریخ انقضا

### 3. Repository Security
- Private repositories
- Branch protection
- Code review requirements

## 📱 ابزارهای مفید

### 1. GitHub Desktop
- رابط گرافیکی برای Git
- مناسب برای تازه‌کاران
- رایگان

### 2. VS Code
- ویرایشگر کد
- پشتیبانی از Git
- extensions مفید

### 3. GitKraken
- رابط گرافیکی پیشرفته
- visualization بهتر
- پولی

## 🎉 مراحل بعدی

### 1. یادگیری Git
- مفاهیم پیشرفته
- دستورات پیچیده
- workflow های مختلف

### 2. GitHub Actions
- CI/CD
- Automation
- Deployment

### 3. Collaboration
- Open source
- Team work
- Community

## 📋 چک‌لیست شروع

### هفته اول:
- [ ] حساب GitHub ایجاد شده
- [ ] Git نصب شده
- [ ] Repository ایجاد شده
- [ ] اولین commit انجام شده

### هفته دوم:
- [ ] پروژه Flutter آپلود شده
- [ ] GitHub Actions فعال شده
- [ ] اولین build انجام شده
- [ ] APK دانلود شده

### هفته سوم:
- [ ] با branch ها کار کرده‌اید
- [ ] Issues ایجاد کرده‌اید
- [ ] README بهبود یافته
- [ ] پروژه آماده انتشار است

---

## 🌟 نکات مهم برای تازه‌کاران

1. **صبر کنید**: یادگیری Git زمان می‌برد
2. **تمرین کنید**: هر روز کمی کار کنید
3. **اشتباه کنید**: از اشتباهات یاد بگیرید
4. **سوال بپرسید**: GitHub community کمک می‌کند
5. **مستندات بخوانید**: بهترین منبع یادگیری

---

**🎉 تبریک! حالا آماده شروع کار با GitHub هستید!**

**💡 یادتان باشد: هر متخصصی روزی تازه‌کار بوده است.** 