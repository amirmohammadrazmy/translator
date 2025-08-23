# مترجم هوشمند (Smart Translator)

A Persian-friendly translation and text-to-speech tool built with Flutter, optimized for Iranian users with subscription support through Cafebazaar.

## 🌟 Features

### Core Functionality
- **Text Translation**: Support for multiple languages using LibreTranslate API
- **Text-to-Speech**: Built-in TTS with Persian and English language support
- **Multi-language UI**: Persian (RTL) and English (LTR) interface support
- **Offline TTS**: Works without internet connection for speech synthesis

### User Experience
- **Daily Persian Quotes**: Motivational quotes displayed at the top of the home screen
- **Translation History**: Stores last 20 translations locally
- **Favorites System**: Save important translations for quick access
- **Search & Filter**: Find translations in history and favorites
- **Copy & Share**: Easy text copying and sharing functionality

### Subscription Model
- **Free Tier**: 3 translations per day
- **Premium Subscription**: 30,000 Toman/month for unlimited translations
- **Cafebazaar Integration**: In-app billing through Iranian app store
- **Automatic Renewal**: Monthly subscription with automatic renewal

### Technical Features
- **Update Enforcement**: Mandatory updates when new versions are available
- **Dark Mode**: Light and dark theme support
- **RTL Layout**: Full right-to-left support for Persian language
- **Responsive Design**: Optimized for various screen sizes
- **Local Storage**: Secure local data storage using SharedPreferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Android SDK (API level 21+)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/persian-translator.git
   cd persian-translator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoints**
   - Update `lib/utils/constants.dart` with your API endpoints
   - Set up version check URL for update enforcement

4. **Add Vazir font files**
   - Place Vazir font files in `assets/fonts/` directory
   - Fonts: Vazir-Regular.ttf, Vazir-Bold.ttf, Vazir-Light.ttf

5. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

1. **Android APK**
   ```bash
   flutter build apk --release
   ```

2. **Android App Bundle (Recommended for Play Store)**
   ```bash
   flutter build appbundle --release
   ```

## 📱 App Structure

### Screens
- **Splash Screen**: App logo and initialization
- **Home Screen**: Main translation interface with daily quotes
- **History Screen**: Translation history with search functionality
- **Favorites Screen**: Saved favorite translations
- **Paywall Screen**: Subscription options and purchase
- **Update Screen**: Mandatory update when version is outdated
- **Settings Screen**: App configuration and preferences

### Providers (State Management)
- **AppProvider**: App-wide state, theme, language, version checking
- **TranslationProvider**: Translation operations, history, favorites, TTS
- **SubscriptionProvider**: Subscription status and billing

### Models
- **Translation**: Translation data structure
- **Subscription**: Subscription status and billing information

## 🔧 Configuration

### Constants (`lib/utils/constants.dart`)
```dart
// API Configuration
static const String translationApiUrl = 'https://libretranslate.de/translate';
static const String versionCheckUrl = 'https://yourusername.github.io/persian-translator/version.json';

// Translation Limits
static const int freeDailyTranslations = 3;
static const int maxHistoryItems = 20;

// Subscription
static const String subscriptionPrice = '30,000';
static const String subscriptionCurrency = 'تومان';
```

### Localization
- **Persian (fa)**: Default language with RTL support
- **English (en)**: Secondary language with LTR support
- **Customizable**: Easy to add more languages

### Theme Configuration
- **Light Theme**: Clean, modern design
- **Dark Theme**: Eye-friendly dark interface
- **Persian Colors**: Iranian-inspired color palette

## 🎨 UI/UX Features

### Design Principles
- **Iranian-Friendly**: Culturally appropriate design elements
- **Modern Interface**: Material Design 3 with custom styling
- **Accessibility**: High contrast, readable fonts, proper spacing
- **Responsive**: Adapts to different screen sizes and orientations

### Color Scheme
- **Primary**: Blue (#1E88E5) - Trust and reliability
- **Secondary**: Orange (#FF6B35) - Energy and creativity
- **Accent**: Green (#4CAF50) - Success and growth
- **Warning**: Amber (#FF9800) - Caution and attention
- **Error**: Red (#F44336) - Errors and warnings

### Typography
- **Vazir Font**: Persian-optimized font family
- **Responsive Sizing**: Adapts to user preferences
- **RTL Support**: Full right-to-left text rendering

## 🔌 API Integration

### Translation API
- **LibreTranslate**: Free, open-source translation service
- **Fallback Support**: Multiple API endpoints for reliability
- **Rate Limiting**: Respectful API usage with proper delays

### Version Checking
- **Remote JSON**: Version information hosted on GitHub Pages
- **Automatic Updates**: Checks for updates on app launch
- **Bazaar Integration**: Direct links to app store for updates

## 💰 Monetization

### Subscription Model
- **Free Tier**: 3 translations per day
- **Premium**: 30,000 Toman/month (≈ 1,000 Toman/day)
- **Features**: Unlimited translations, premium features, no ads

### Cafebazaar Integration
- **In-App Billing**: Secure payment processing
- **Subscription Management**: Automatic renewal and cancellation
- **Receipt Validation**: Server-side purchase verification

## 📊 Data Management

### Local Storage
- **SharedPreferences**: User settings and preferences
- **Translation History**: Last 20 translations
- **Favorites**: User-saved translations
- **Subscription Status**: Billing information

### Data Persistence
- **Automatic Backup**: Data preserved across app updates
- **Export/Import**: User data portability
- **Privacy**: No personal data sent to external servers

## 🚀 Deployment

### Cafebazaar Publishing
1. **Build Release APK/Bundle**
2. **Sign with Release Keystore**
3. **Upload to Cafebazaar Developer Console**
4. **Configure In-App Billing**
5. **Submit for Review**

### Version Management
- **Semantic Versioning**: Major.Minor.Patch format
- **Update Enforcement**: Mandatory updates for security
- **Rollback Support**: Graceful handling of update failures

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Manual Testing
- **RTL Layout**: Persian language interface
- **Translation**: Multiple language pairs
- **TTS**: Text-to-speech functionality
- **Subscription**: Purchase flow and validation

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit pull request

### Code Style
- **Dart Format**: Use `dart format` for consistent code style
- **Comments**: Comprehensive documentation for complex logic
- **Naming**: Clear, descriptive variable and function names
- **Architecture**: Follow Flutter best practices and patterns

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Vazir Font**: Persian typography by Saber Rastikerdar
- **LibreTranslate**: Open-source translation service
- **Flutter Team**: Amazing cross-platform framework
- **Iranian Developer Community**: Support and feedback

## 📞 Support

- **Email**: support@behtarinarts.ir
- **Telegram**: @persian_translator_support
- **Website**: https://behtarinarts.ir
- **Documentation**: [Wiki](https://github.com/yourusername/persian-translator/wiki)

## 🔮 Future Roadmap

### Planned Features
- **Offline Translation**: Download language packs for offline use
- **Voice Input**: Speech-to-text for hands-free translation
- **Camera Translation**: OCR-based text translation
- **Conversation Mode**: Real-time conversation translation
- **Multiple Accounts**: Family sharing and team features

### Technical Improvements
- **Performance**: Optimize translation speed and memory usage
- **Security**: Enhanced encryption and secure storage
- **Analytics**: User behavior insights and performance metrics
- **A/B Testing**: Feature experimentation and optimization

---

**Made with ❤️ for the Iranian community**

*مترجم هوشمند - بهترین مترجم فارسی* 